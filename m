Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0584EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0A421670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560949499;
	bh=n3KLKYts4K5N4cb9g1hjz5TkGGFF3p2iFeK6laS3lLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HB0LsM+z62XqpjGmm0V9Wtw8YbbHbKtzQrCd8hTAQuw1XQcTHTOpMS6sw09lqlRtV
	 +hR89jctrINyrSiSg7r1PVE9wqxNHEYH6F6o4JFvTBMdxPSjMeDEt/UN+FcoO0JOVv
	 iSFWf7JVJNrMcAaiu+YCo3AIyO3NrC3JhsyvgiC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfFSNE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:04:58 -0400
Received: from casper.infradead.org ([85.118.1.10]:58188 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbfFSNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q/WTcjyOBpwvuJ+QVqRXy4uVu6c2/vfcA6WupQADJMI=; b=YTJGhL/roGk88lmexW/uHWOlaQ
        EgYa65sYpAqt0Ty0JEH4izzuNiP8UlBPniX9w/09Bqsj2KUJQHW4ztl63QKu76k0ZvNdASWQFW+dO
        EjKefNvevynwr1e32AJywF2TY4nSKlGjfRKrux47BVetV4ZtRdeKlPhgbfye+Xk0/gRKIdXWSPpFW
        /HAavLrrm1omA+AZ8SBiG2YiW3TCjVyIM7aQx3exufHXxNUfexymhQssSFRRyXgVNeGCSOFIGP0V9
        jvRooAWWvXgmz5j4/1Op3L5VSdVIBa2yjcirDpeemqYN12m7ov/r/Oty89RWEM2XZLFtps2XGTJg/
        S6rJGcdA==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdaGm-0001Hv-9H; Wed, 19 Jun 2019 13:04:56 +0000
Date:   Wed, 19 Jun 2019 10:04:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619100450.26d4d6f7@coco.lan>
In-Reply-To: <20190619104239.GM3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
        <20190619072218.4437f891@coco.lan>
        <20190619104239.GM3419@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 19 Jun 2019 12:42:39 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

(reduced the C/C to just the relevant ML/people)

> On Wed, Jun 19, 2019 at 07:22:18AM -0300, Mauro Carvalho Chehab wrote:
> > Hi Daniel,
> > 
> > Em Wed, 19 Jun 2019 11:05:57 +0200
> > Daniel Vetter <daniel@ffwll.ch> escreveu:
> >   
> > > On Tue, Jun 18, 2019 at 10:55 PM Mauro Carvalho Chehab
> > > <mchehab+samsung@kernel.org> wrote:  
> > > > diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> > > > index fa30dfcfc3c8..b0f948d8733b 100644
> > > > --- a/Documentation/gpu/drm-mm.rst
> > > > +++ b/Documentation/gpu/drm-mm.rst
> > > > @@ -320,7 +320,7 @@ struct :c:type:`struct file_operations <file_operations>` get_unmapped_area
> > > >  field with a pointer on :c:func:`drm_gem_cma_get_unmapped_area`.
> > > >
> > > >  More detailed information about get_unmapped_area can be found in
> > > > -Documentation/nommu-mmap.rst
> > > > +Documentation/driver-api/nommu-mmap.rst    
> > > 
> > > Random drive-by comment: Could we convert these into hyperlinks within
> > > sphinx somehow, without making them less useful as raw file references
> > > (with vim I can just type 'gf' and it works, emacs probably the same).
> > > -Daniel  
> > 
> > Short answer: I don't know how vim/emacs would recognize Sphinx tags.  
> 
> No, the other way around, Sphinx can recognize local files and treat
> them special. That way we keep the text readable.
> 
> Same with that :c:func:'foo' crap, that needs to die, and Sphinx needs
> to be taught about foo().

Just did a test today with Jon's extension with is meant to replace
:c:func:'foo' (with is currently on a separate 'automarkup' branch).
At least the version therestill needs some work, as it currently 
mangles with titles and tables. like on those warnings/errors:

	6.4 :c:func:`resync_start()`, :c:func:`resync_finish()`
	-----------------------------------
	/devel/v4l/docs/Documentation/driver-api/md/md-cluster.rst:323: WARNING: Title underline too short.


	/devel/v4l/docs/Documentation/driver-api/serial/tty.rst:74: WARNING: Malformed table.
	Text in column margin in table line 34.

	======================= =======================================================
	:c:func:`open()`                        Called when the line discipline is attached to

-

That's said, once it gets fixed to address those complex cases, a
regex like:

	\bDocumentation/([\w\d\-\_\/]+)\.rst\b

could be used to convert to :doc: tag. It should be smart enough to convert
the relative paths, as we refer to the files from the git root directory
(with makes a lot sense to me), while Sphinx :doc: use relative patches
from the location where the parsed file is.

Something like the enclosed patch. 

Thanks,
Mauro

[PATCH] automarkup.py: convert Documentation/* to hyperlinks

Auto-create hyperlinks when it finds a Documentation/.. occurrence.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index 39c8f4d5af82..9d6926b61241 100644
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
@@ -63,7 +80,17 @@ def MangleFile(app, docname, text):
         # Normal line - perform substitutions.
         #
         else:
-            ret.append(RE_function.sub(r'\1:c:func:`\2`\3', line))
+            new_line = RE_function.sub(r'\1:c:func:`\2`\3', line)
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


