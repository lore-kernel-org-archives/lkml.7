Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E043AC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF021783
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956555;
	bh=i4/m3cIIMx/tLIWnle/7SzNdGXGSZwSyGBjeAJGPYwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yTBgYIov5ZnoPTn6BmXXMquO5DcK5xqMh9Fi3CCbP8Mbw/obpFCqEQNW9VnJYfpxv
	 C5Yb//gk5PXlkOGFlvQScLaHY3EKueRGrf92xa5rOgMUwy3zLfn1cqE6yDuiMo0k99
	 +CC4sF8ihS2skVUzoentUJPm5YyygEDUsCVdtfI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfFSPCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:02:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FDFL6FNwMO+N2Z7jWsOhRNSUjHzRNRrq16HYq8Dyh38=; b=H02KpYZ7ruYvHwfH7uxOGeNVR
        31p9TXM4uwYkgvcddya5pywozyXwJCwoPGcsHKtaDMTTJPFiDpIqnYZ+rKRpTcWF0XmZe0MZbbLzi
        RAeeF5C+uyoN5Vzbcb7URPbiCV7cH/x0c9gERr8CMbnTbXUwV09cdQViE3GrP83nq/3zr11kMHsL9
        hU6MBkOm2YeWN/7qgK5nJxuyzgZq9xzNE3PI5EQ4ykwIDhMplp+TyQweP/oE6JXy7RzUT9psv6pf4
        t0/oY/z4zS3mMoQrQHmhKOsIfNdyrsy2AgSgK5lGK7zRde24ZDtMo7UY+bXrq0CwDiEWsjTuM3YBA
        pc5i6WViQ==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdc6b-0008Kr-9b; Wed, 19 Jun 2019 15:02:33 +0000
Date:   Wed, 19 Jun 2019 12:02:29 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619120229.78ce6e07@coco.lan>
In-Reply-To: <20190619081353.75762028@lwn.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
        <20190619072218.4437f891@coco.lan>
        <20190619104239.GM3419@hirez.programming.kicks-ass.net>
        <20190619081353.75762028@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Em Wed, 19 Jun 2019 08:13:53 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 19 Jun 2019 12:42:39 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > No, the other way around, Sphinx can recognize local files and treat
> > them special. That way we keep the text readable.
> > 
> > Same with that :c:func:'foo' crap, that needs to die, and Sphinx needs
> > to be taught about foo().  
> 
> I did a patch to make that latter part happen, but haven't been able to
> find the time to address the comments and get it out there.  It definitely
> cleaned up the source files a lot and is worth doing.  Will try to get
> back to it soon.

See my comment. Yeah, the :c:func:'foo' (the version you merged at the automarkup
branch) has currently a bug, when there's something like:

	func()
	======

or when func() is inside a table.

Solving the table case would be a lot better if the plugin could run the
existing table parser and only then handle the cross-reference replacements,
but I've no idea how flexible the Sphinx plugins can be.

> 
> The local file links should be easy to do; we shouldn't need to add any
> markup for those.

Yeah, those are easy - except if someone adds a Documentation/* link 
inside a table or inside a topic header.

Running a modified version of your tool shows just two new warnings:

	Documentation/translations/ja_JP/howto.rst:176: WARNING: undefined label: :doc: (if the link has no caption the label must precede a section header)         
	Documentation/translations/zh_CN/process/submitting-drivers.rst:25: WARNING: unknown document: ../../../Documentation/translations/zh_CN/process/submitting-patches

The first one is because of this:

	:Ref:`Documentation/process/kernel-docs.rst <kernel_docs>`

(my parser didn't consider upper-case tags - a simple fix at a regex should
fix this)

The second one is because the URL is wrong. It is pointing to:

	Documentation/Documentation/translations/zh_CN/process/submitting-patches

at Chinese translation.

So, at least the way our documentation is, the plugin seems to be working
as expected.

As a reference, I'm enclosing the diff against your patch:

    commit 6231d7456e87bd3e11f892709945887bd55a8a20 (docs/automarkup)
    Author: Jonathan Corbet <corbet@lwn.net>
    Date:   Thu Apr 25 07:55:07 2019 -0600

        Docs: An initial automarkup extension for sphinx
    
        Rather than fill our text files with :c:func:`function()` syntax, just do
        the markup via a hook into the sphinx build process.  As is always the
        case, the real problem is detecting the situations where this markup should
        *not* be done.
    
        Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks,
Mauro

-

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index 39c8f4d5af82..60dad596c790 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -9,6 +9,7 @@
 from __future__ import print_function
 import re
 import sphinx
+#import sys		# Just for debug
 
 #
 # Regex nastiness.  Of course.
@@ -31,10 +32,26 @@ RE_literal = re.compile(r'^(\s*)(.*::\s*|\.\.\s+code-block::.*)$')
 #
 RE_whitesp = re.compile(r'^(\s*)')
 
+#
+# Get a documentation reference
+#
+RE_doc_links = re.compile(r'\bDocumentation/([\w\d\-\_\/]+)\.rst\b')
+
+#
+# Doc link false-positives
+#
+RE_false_doc_links = re.compile(r':ref:`\s*Documentation/[\w\d\-\_\/]+\.rst')
+
 def MangleFile(app, docname, text):
     ret = [ ]
     previous = ''
     literal = False
+
+    rel_dir = ''
+
+    for depth in range(0, docname.count('/')):
+        rel_dir += "../"
+
     for line in text[0].split('\n'):
         #
         # See if we might be ending a literal block, as denoted by
@@ -63,7 +80,18 @@ def MangleFile(app, docname, text):
         # Normal line - perform substitutions.
         #
         else:
-            ret.append(RE_function.sub(r'\1:c:func:`\2`\3', line))
+#            new_line = RE_function.sub(r'\1:c:func:`\2`\3', line)
+            new_line = line
+
+            if not RE_false_doc_links.search(new_line):
+                new_line = RE_doc_links.sub(r':doc:`' + rel_dir + r'\1`', new_line)
+
+ #           # Just for debug - should be removed on production
+ #           if new_line != line:
+ #               print ("===>" + new_line, file=sys.stderr)
+
+            ret.append(new_line)
+
         #
         # Might we be starting a literal block?  If so make note of
         # the fact.


