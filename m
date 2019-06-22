Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C6C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA972075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 01:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561165253;
	bh=gW83MqmQ4vYm32CNGU0mHcs2vIp5/i8Athw9vKKHmd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y6T2u4TdIaoIjii4KqcBsW2DsYWx3ha9cRvhNeeG717MrzAJKow9n56NK2yXqnsQM
	 Vd80UmAIeqE7TCozB7yoRZSuNbonAMFk9Y1icl+Mr2+JOZbCsR1Tvwv7+zBkh8QKJZ
	 QDPNqm3DVzRzDXApcT5yQF393LRcw3lXtIKR4V3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFVBAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 21:00:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFVBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 21:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DU48MQ9NZfd+dSFfhOVoqXBfrwMyOEsLPRg6YgjyGVI=; b=jhnuriO1MsaxnCd+jswIlYNwI
        Z9eslOz5YY12SaOn2HmpCg3Jjl4UqJjNP2k5zUwZj75rfZRq1UVKMCePjopb2cwljbOaARcLctBH2
        DIViKJ99NFy4w6DrFV48ErW/6qj3bFpd76z3SGTnEIo21MxhAkxSSsWIR4TFBoqJNpUYtEb0IXG+D
        SipccnLUPJWlru8gtR60doHGE3X6te2sdU8mH+2QFM0faKrN5FxXIyOD93P4cWRoUk20PsX9gxkRk
        m6RXGIxb7Zv/W9PlhqvMCVq5bNNdFiha/aT2g+TXkua+ML2H1KbQeWS7EYw4BlLxENbiqa2rYWzr3
        8paKyQXWA==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heUOg-00055M-PZ; Sat, 22 Jun 2019 01:00:51 +0000
Date:   Fri, 21 Jun 2019 22:00:46 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs: An initial automarkup extension for sphinx
Message-ID: <20190621220046.3de30d9d@coco.lan>
In-Reply-To: <20190621235159.6992-2-corbet@lwn.net>
References: <20190621235159.6992-1-corbet@lwn.net>
        <20190621235159.6992-2-corbet@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 Jun 2019 17:51:57 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Rather than fill our text files with :c:func:`function()` syntax, just do
> the markup via a hook into the sphinx build process.


Didn't test it, but it sounds a way nicer than the past version!

> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py              |  3 +-
>  Documentation/sphinx/automarkup.py | 80 ++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sphinx/automarkup.py
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 7ace3f8852bd..a502baecbb85 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -34,7 +34,8 @@ needs_sphinx = '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig']
> +extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> +              'kfigure', 'sphinx.ext.ifconfig', 'automarkup']
>  
>  # The name of the math extension changed on Sphinx 1.4
>  if (major == 1 and minor > 3) or (major > 1):
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> new file mode 100644
> index 000000000000..14b09b5d145e
> --- /dev/null
> +++ b/Documentation/sphinx/automarkup.py
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019 Jonathan Corbet <corbet@lwn.net>
> +#
> +# Apply kernel-specific tweaks after the initial document processing
> +# has been done.
> +#
> +from docutils import nodes
> +from sphinx import addnodes
> +import re
> +
> +#
> +# Regex nastiness.  Of course.
> +# Try to identify "function()" that's not already marked up some
> +# other way.  Sphinx doesn't like a lot of stuff right after a
> +# :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
> +# bit tries to restrict matches to things that won't create trouble.
> +#
> +RE_function = re.compile(r'([\w_][\w\d_]+\(\))')
> +
> +#
> +# The DVB docs create references for these basic system calls, leading
> +# to lots of confusing links.  So just don't link them.
> +#
> +Skipfuncs = [ 'open', 'close', 'write' ]

and yeah, of course, if there's something weird, it has to be at
the media docs :-)

Btw, if I'm not mistaken, we do the same for ioctl.


I'm wandering if this could also handle the Documentation/* auto-replace.

The patch snipped I did (against your past version is enclosed).


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


Thanks,
Mauro
