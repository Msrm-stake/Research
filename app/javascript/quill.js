document.addEventListener("turbo:load", () => {
  // Register a custom divider blot
  const BlockEmbedBlot = Quill.import('blots/block/embed');

  class DividerBlot extends BlockEmbedBlot {
    static create() {
      const node = super.create();
      node.setAttribute('class', 'divider'); // Add a class for styling
      return node;
    }

    static formats(node) {
      return true; // No specific formats for the divider
    }

    static blotName = 'divider';
    static tagName = 'HR'; // Use <hr> for the divider
  }

  Quill.register(DividerBlot);

  // Initialize Quill editor
  const quill = new Quill('#editor', {
    theme: 'snow',
    modules: {
      toolbar: [
        ['bold', 'italic', 'underline', 'strike'], 
        [{ header: [1, 2, 3, 4, 5, 6, false] }],
        [{ list: 'ordered' }, { list: 'bullet' }],
        ['link', 'image'],
        [{ align: [] }],
        ['clean'],
        ['blockquote', 'code-block'], // Added blockquote and code block
        [{ color: [] }, { background: [] }], // Added text color and background color
        ['formula'], // Added formula button
        ['divider'], // Custom divider button
      ],
    },
  });

  // Add a handler for the custom divider button
  const toolbar = quill.getModule('toolbar');
  toolbar.addHandler('divider', () => {
    const range = quill.getSelection(true);
    quill.insertEmbed(range.index, 'divider', true, 'user');
    quill.setSelection(range.index + 1, 0, 'user');
  });

  // Set initial content from hidden field
  const initialContent = document.querySelector('#hidden-editor-body').value;
  if (initialContent) {
    quill.clipboard.dangerouslyPasteHTML(initialContent);
  }

  // Update hidden field on form submit
  const form = document.querySelector('form');
  form.addEventListener('submit', () => {
    const hiddenField = document.querySelector('#hidden-editor-body');
    hiddenField.value = quill.root.innerHTML;
  });
});