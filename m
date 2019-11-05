Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D175C49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D0A20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b+NWHmUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfKEJNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:13:05 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27790 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfKEJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:13:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191105091302epoutp04b17064effff4231a262819185be32256~UOU864WS52378023780epoutp04r
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 09:13:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191105091302epoutp04b17064effff4231a262819185be32256~UOU864WS52378023780epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572945182;
        bh=CzrLhLMfiUzAG7RmdPIH+UlbVTImdtVhtEnWRgE/ibk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=b+NWHmUJi8xZasCodeW40UL1h0GgsjFUZG3Id31iOvQaodG2siIgtR5udCN3Lj4n3
         I0kRpb/ZjJcV9M0m8iEpAN7jnwaPHnH1RS+t5cPaWkqo/7TKykOe+0W9psLmJZuD4r
         7TWccYPpprokNbGIpysXItA/P4mi6pjiPrTh9+v4=
Received: from epcpadp2 (unknown [182.195.40.12]) by epcas1p3.samsung.com
        (KnoxPortal) with ESMTP id
        20191105091301epcas1p3f03cf7a861f1f2f60a1461a013073bf6~UOU8Mn7bf0930209302epcas1p3m;
        Tue,  5 Nov 2019 09:13:01 +0000 (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH] MAINTAINERS: Update myself as maintainer for DEVFREQ
 subsystem support
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh@kernel.org" <robh@kernel.org>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        CPGS <cpgs@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1019298652.01572934681167.JavaMail.epsvc@epcpadp2>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1019298652.01572945181528.JavaMail.epsvc@epcpadp2>
Date:   Tue, 05 Nov 2019 16:35:05 +0900
X-CMS-MailID: 20191105073505epcms1p243aa08867cb813b6329a3ba89b832a8a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5
References: <1019298652.01572934681167.JavaMail.epsvc@epcpadp2>
        <CGME20191105053547epcas1p248c5a77579a8dd6fbd3639a12f3ca4c5@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Update myself to the DEVFREQ entry as maintainer from reviewer and
>the git repository information to manage the devfreq patches. I've been
>reviewing and tesing the devfreq support for the couple of years as reviewer.
>From now, I'll help and reiview the devfreq as maintainer.
>
>Suggested-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Thanks a lot, Chanwoo!

>---
> MAINTAINERS | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index cba1095547fd..ebc1078c1ecb 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -3532,7 +3532,7 @@ BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
> M:	Chanwoo Choi <cw00.choi@samsung.com>
> L:	linux-pm@vger.kernel.org
> L:	linux-samsung-soc@vger.kernel.org
>-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> S:	Maintained
> F:	drivers/devfreq/exynos-bus.c
> F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>@@ -4762,9 +4762,9 @@ F:	include/linux/devcoredump.h
> DEVICE FREQUENCY (DEVFREQ)
> M:	MyungJoo Ham <myungjoo.ham@samsung.com>
> M:	Kyungmin Park <kyungmin.park@samsung.com>
>-R:	Chanwoo Choi <cw00.choi@samsung.com>
>+M:	Chanwoo Choi <cw00.choi@samsung.com>
> L:	linux-pm@vger.kernel.org
>-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> S:	Maintained
> F:	drivers/devfreq/
> F:	include/linux/devfreq.h
>@@ -4774,7 +4774,7 @@ F:	include/trace/events/devfreq.h
> DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
> M:	Chanwoo Choi <cw00.choi@samsung.com>
> L:	linux-pm@vger.kernel.org
>-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> S:	Supported
> F:	drivers/devfreq/event/
> F:	drivers/devfreq/devfreq-event.c
>-- 
>2.17.1
>

