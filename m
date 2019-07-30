Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB48C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34479206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfG3PAy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:00:54 -0400
Received: from mail.cloudbasesolutions.com ([91.232.152.5]:56946 "EHLO
        mail.cloudbasesolutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729745AbfG3PAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:00:53 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 11:00:51 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.cloudbasesolutions.com (Postfix) with ESMTP id 9FC34401AC;
        Tue, 30 Jul 2019 17:53:37 +0300 (EEST)
X-Virus-Scanned: amavisd-new at cloudbasesolutions.com
Received: from mail.cloudbasesolutions.com ([127.0.0.1])
        by localhost (mail.cloudbasesolutions.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c3lqKTaK6aff; Tue, 30 Jul 2019 17:53:37 +0300 (EEST)
Received: from mail.cloudbasesolutions.com (unknown [10.77.78.3])
        by mail.cloudbasesolutions.com (Postfix) with ESMTP id 16E333FB5C;
        Tue, 30 Jul 2019 17:53:36 +0300 (EEST)
Received: from CBSEX1.cloudbase.local ([10.77.78.3]) by CBSEX1.cloudbase.local
 ([10.77.78.3]) with mapi id 14.03.0468.000; Tue, 30 Jul 2019 17:53:36 +0300
From:   Adrian Vladu <avladu@cloudbasesolutions.com>
To:     Sasha Levin <sashal@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "KY Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: RE: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Thread-Topic: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Thread-Index: AQHVBDHgWNITe/5yDUiixarWB+egkaZe6YqAgALjioCAgfdowA==
Date:   Tue, 30 Jul 2019 14:53:35 +0000
Message-ID: <F5008595B06C564AB347C30B4FDE4BC559697F85@CBSEX1.cloudbase.local>
References: <20190506172737.18122-1-avladu@cloudbasesolutions.com>
 <20190506173331.18906-1-avladu@cloudbasesolutions.com>
 <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190509010941.GT1747@sasha-vm>
In-Reply-To: <20190509010941.GT1747@sasha-vm>
Accept-Language: en-GB, ro-RO, it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.77.78.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There were two patches you have queued for hyperv-fixes a while ago, but I don't see them anymore in the hyperv-fixes tree:
https://lore.kernel.org/patchwork/patch/1070848/
https://lore.kernel.org/patchwork/patch/1070806/

I have checked them and they can still be applied successfully on the latest master tree.
Please let me know if I need to make some amends to get them merged.

Much appreciated,
Adrian Vladu

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Thursday, May 9, 2019 4:10 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; linux-
> kernel@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Alessandro Pilotti <apilotti@cloudbasesolutions.com>
> Subject: Re: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
> lsvmbus
> 
> On Tue, May 07, 2019 at 05:02:47AM +0000, Dexuan Cui wrote:
> >> From: Adrian Vladu <avladu@cloudbasesolutions.com>
> >> Sent: Monday, May 6, 2019 10:34 AM
> >> To: linux-kernel@vger.kernel.org
> >> Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; KY Srinivasan
> >> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> >> Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
> >> Dexuan Cui <decui@microsoft.com>; Alessandro Pilotti
> >> <apilotti@cloudbasesolutions.com>
> >> Subject: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for lsvmbus
> >>
> >> Fixed pep8/flake8 python style code for lsvmbus tool.
> >>
> >> The TAB indentation was on purpose ignored (pep8 rule W191) to make
> >> sure the code is complying with the Linux code guideline.
> >> The following command do not show any warnings now:
> >> pep8 --ignore=W191 lsvmbus
> >> flake8 --ignore=W191 lsvmbus
> >>
> >> Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> >>
> >> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> >> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> >> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> >> Cc: Sasha Levin <sashal@kernel.org>
> >> Cc: Dexuan Cui <decui@microsoft.com>
> >> Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
> [...]
> >Looks good to me. Thanks, Adrian!
> >
> >Reviewed-by: Dexuan Cui <decui@microsoft.com>
> 
> Queued for hyperv-fixes, thanks!
> 
> --
> Thanks,
> Sasha
