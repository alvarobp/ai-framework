# Generate Newsletters Digest

IMPORTANT: First check if there are any unread emails in the "Tech Subscriptions" label. If there are no unread emails, do not generate any digest and exit with a message saying "No unread emails found in Tech Subscriptions label."

Retrieve my unread newsletters from the `Tech Subscriptions` gmail label. 

Requirements:
- Get ALL unread entries in the specified timeframe by paginating through results until complete
- Read full content for each email thread to capture complete information
- Generate a well-organized web page that presents:

STRUCTURE:
1. Stats bar showing one row with stats, including total unread count at the top
2. Newsletter summaries in strict chronological order by date (oldest first) - MUST be properly sorted by email date with:
   - Title, author, date, and permalink to original post
   - 2-3 sentence summary of main content
   - Key insights section with 3-4 bullet points of actionable takeaways
   - Referenced tools/links mentioned in the article
   - Appropriate category tag (AI, Management, Development, etc.)
3. Knowledge Pills section at the end featuring:
   - Major concepts, frameworks, tools, and patterns encountered
   - Brief description of each concept's value/application
   - Links back to the articles that reference each concept
   - Focus on learnable/actionable knowledge worth exploring further

VERIFICATION:
- Confirm all unread articles from the timeframe are included as data sources
- Ensure no newsletters are missed due to pagination limits
- Cross-reference that every Knowledge Pill links back to its source articles
- CRITICAL: Verify that all newsletter summaries are properly sorted by date in chronological order (oldest first) - check that earlier dates (e.g., Sept 9) appear before later dates (e.g., Sept 11)

FORMATTING:
- Create as responsive HTML with modern styling
- Use engaging visual design with gradients and cards
- Include hover effects and proper typography
- Mobile-friendly layout

Use newsletters-digest-template.html as template for the web page code.

Generate a comprehensive digest that serves as both a reference document and learning roadmap for the valuable insights from this period's newsletter reading.


