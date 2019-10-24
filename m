Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF19CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E0205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408807AbfJXH6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:58:34 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54294
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408694AbfJXH6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:58:34 -0400
X-IronPort-AV: E=Sophos;i="5.68,224,1569276000"; 
   d="scan'208";a="324077627"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 09:58:31 +0200
Date:   Thu, 24 Oct 2019 09:58:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Zhong Shiqi <zhong.shiqi@zte.com.cn>
Subject: Re: [PATCH v2] coccicheck: support $COCCI being defined as a
 directory
In-Reply-To: <37ad0bcd-941d-e02e-ae99-e89f2ce98ff0@web.de>
Message-ID: <alpine.DEB.2.21.1910240956450.4479@hadrien>
References: <alpine.DEB.2.21.1910240816040.2771@hadrien> <37ad0bcd-941d-e02e-ae99-e89f2ce98ff0@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1170188596-1571903912=:4479"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1170188596-1571903912=:4479
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Oct 2019, Markus Elfring wrote:

> > Second the commit log could be more concise as:
>
> I like your desire for choosing a more appropriate commit message.
>
>
> > Allow defining COCCI as a directory that contains .cocci files.
>
> I would prefer to concentrate the patch subject on other information.
>
>
> > In general, at least in simple cases, it is not necessary to mention the
> > name of the file you are modifying in the comit log, because one can see
> > that just below from looking at the diffstat and the patch.
>
> This view can be reasonable. - How does it fit to the usual requirement
> for the specification of a “subsystem” (or “prefix”) according to the
> canonical patch format?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=13b86bc4cd648eae69fdcf3d04b2750c76350053#n656

Huh?  I was talking about the log message, not the subject line.  Likewise
"Allow defining..." was not proposed as a subject line, but as the log
message.  With that degree of orientation, I think one can look at the
code and figure out what the intent is.  At least if one knows the meaning
of -d.

julia
--8323329-1170188596-1571903912=:4479--
