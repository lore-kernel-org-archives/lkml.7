Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C56DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2492A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Ug8tp6XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfEVUSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:18:30 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:35148 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfEVUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:18:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 2CE96A30;
        Wed, 22 May 2019 22:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1558556305; x=1560370706; bh=nuiAT7a+WubQ1QBLbWqHmT5WyMcVembEwR6
        mVvVMEiY=; b=Ug8tp6XKTpZa5LJXo7fm0ycgXuCPIDeLmjkirEb7bc3BHkVcv5j
        DxAepKV6LWi/SZl6nec2N5/F3s+8uRgecJVQQzIwG8cueywEP/HnAnKFDOtHmAkc
        vol3RzPQBr+o+9oONkj3ghVyuWNRhkRZg+5gaILM/JFII44Y83qtDYI70Z7Zb5wj
        f/6xqoF0WhmidWnNA8cId8/2+YOqN2Lis0Qg7EQFp63vViF4/js2DcYM2IEJS2uJ
        06efi7XWICVfjlwRADEEdt/pD+ZLNNVOr+deiKlDQTMhIPVxB8prz+xJ3KWpWezH
        tmRxSxGHECEMwyM/qXrSL0MlR0Bp7QSd4ww0Ci9KggYLcT/BuPaVWS0NUI9Jul8r
        i28OAj8+2FSa1/6qClljNA9eVDszn4hQGTOF5psjPhcBtNtS0DwC+Rlw5wcRlKpM
        EyBhu58u11p7uz5bChSS2mdRSJO+rCPue18lgNamDUvISVJqHgKqXg1IcrX1wDXb
        i8mnKOgnUt6hspj4L/5jpUWsYOIcQmLWs6EbL8lelrkjL5h0P8fffnoE7Zaf39oT
        mtR7IymePL4/o7H7UOMWNETe2O9v5PJ2zdYkkUB5MnGsFNz7sykeS/kCcK4iQJgE
        uQtp9ew3Dht6FGK5+66T9KSbMB7LdhbcGfTLGVMLL9IHmctLIAizL7F8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7BaCIysCNlh7; Wed, 22 May 2019 22:18:25 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 3A02B34B;
        Wed, 22 May 2019 22:18:25 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id C22B13D16;
        Wed, 22 May 2019 22:18:24 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/10] Fix broken documentation references at v5.2-rc1
Date:   Wed, 22 May 2019 22:18:23 +0200
Message-ID: <4613410.CTphFSq3dd@harkonnen>
In-Reply-To: <20190521212600.39bc341c@coco.lan>
References: <cover.1558362030.git.mchehab+samsung@kernel.org> <51951662.QppCrsbGrr@harkonnen> <20190521212600.39bc341c@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 22, 2019 2:26:00 AM CEST Mauro Carvalho Chehab wrote:
> Hi Frederico,
> 
> Em Wed, 22 May 2019 00:54:48 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> escreveu:
> > On Monday, May 20, 2019 4:47:29 PM CEST Mauro Carvalho Chehab wrote:
> > > There are several broken Documentation/* references within the Kernel
> > > tree. There are some reasons for several of them:
> > > 
> > > 1. The acpi and x86 documentation files were renamed, but the
> > > 
> > >    references weren't updated;
> > > 
> > > 2. The DT files have been converted to JSON format, causing them
> > > 
> > >    to be renamed;
> > > 
> > > 3. Translated files point to future translation work still pending merge
> > > 
> > >    or require some action from someone that it is fluent at the
> > >    translated language;
> > 
> > Hi Mauro
> 
> My main goal with this patchset is to get as close as possible to zero
> warnings, as this helps me on rebasing a documentation patch series
> I wrote with renames hundreds of file from .txt to .rst.
> 
> In the case of (3), the scripts/documentation-file-ref-check was unable to
> find some files pointed by Italian and Chinese translations. So, after
> this series, it will keep pointing for broken links there.
> 
> > I am not sure to get what you mean in terms of actions but I think you are
> > referring to the "empty" files I added in the Italian translations. I
> > added
> > those files to avoid broken links; the alternative would have been to not
> > write those links or to point directly to the main document, but in both
> > cases it easy to forget to update them later.
> > I chose to have links to "empty" files so that the document does
> > not need to be updated later.
> > 
> > If you are not referring to those files than I am not understanding, can
> > you point to a clear example?
> 
> What I meant is that I can barely read Italian and have no glue on
> Chinese. So, I can't really address those properly :-)
> So, basically, it should be up to someone else fluent on such
> languages to address those.
> 
> Btw, I understand why you pointed to some non-existing files:
> translating the Kernel's documents takes a lot of time[1].

More than non-existing the file *should* be there, only that it says the 
translation is pending. So the tool should find the file without complaining.

I did not pay enough attention; I was not aware about the existence of that 
tool. Now that I filled my ignorance with a bit of knowledge I will use to fix 
those documents. Thank you

> 
> [1] If I was doing a translation, I would probably have opted to keep
> pointing to the English doc and have a script to point me links to
> non-translated docs, but your way also works. The only drawback is that
> the script will keep pinpointing to translations with broken links,
> while the translation is not complete.
> 
> Thanks,
> Mauro




