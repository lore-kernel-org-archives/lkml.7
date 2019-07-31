Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5638C206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfGaIvb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:51:31 -0400
Received: from mail.cloudbasesolutions.com ([91.232.152.5]:40862 "EHLO
        mail.cloudbasesolutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbfGaIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:51:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.cloudbasesolutions.com (Postfix) with ESMTP id AD23C40202;
        Wed, 31 Jul 2019 11:51:28 +0300 (EEST)
X-Virus-Scanned: amavisd-new at cloudbasesolutions.com
Received: from mail.cloudbasesolutions.com ([127.0.0.1])
        by localhost (mail.cloudbasesolutions.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UD0F8Q3V59Ke; Wed, 31 Jul 2019 11:51:28 +0300 (EEST)
Received: from mail.cloudbasesolutions.com (unknown [10.77.78.3])
        by mail.cloudbasesolutions.com (Postfix) with ESMTP id 1E1923FB0A;
        Wed, 31 Jul 2019 11:51:28 +0300 (EEST)
Received: from CBSEX1.cloudbase.local ([10.77.78.3]) by CBSEX1.cloudbase.local
 ([10.77.78.3]) with mapi id 14.03.0468.000; Wed, 31 Jul 2019 11:51:27 +0300
From:   Adrian Vladu <avladu@cloudbasesolutions.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: RE: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Thread-Topic: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Thread-Index: AQHVBDHgWNITe/5yDUiixarWB+egkaZe6YqAgALjioCAgfdowIAATBUAgADhEgA=
Date:   Wed, 31 Jul 2019 08:51:26 +0000
Message-ID: <F5008595B06C564AB347C30B4FDE4BC5596986FB@CBSEX1.cloudbase.local>
References: <20190506172737.18122-1-avladu@cloudbasesolutions.com>
 <20190506173331.18906-1-avladu@cloudbasesolutions.com>
 <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190509010941.GT1747@sasha-vm>
 <F5008595B06C564AB347C30B4FDE4BC559697F85@CBSEX1.cloudbase.local>
 <20190730222500.GG29162@sasha-vm>
In-Reply-To: <20190730222500.GG29162@sasha-vm>
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

Great, thank you!

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Wednesday, July 31, 2019 1:25 AM
> To: Adrian Vladu <avladu@cloudbasesolutions.com>
> Cc: Dexuan Cui <decui@microsoft.com>; linux-kernel@vger.kernel.org; KY
> Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>; Alessandro Pilotti
> <apilotti@cloudbasesolutions.com>
> Subject: Re: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
> lsvmbus
> 
> On Tue, Jul 30, 2019 at 02:53:35PM +0000, Adrian Vladu wrote:
> >Hello,
> >
> >There were two patches you have queued for hyperv-fixes a while ago, but I
> don't see them anymore in the hyperv-fixes tree:
> >https://lore.kernel.org/patchwork/patch/1070848/
> >https://lore.kernel.org/patchwork/patch/1070806/
> >
> >I have checked them and they can still be applied successfully on the latest
> master tree.
> >Please let me know if I need to make some amends to get them merged.
> 
> They must have got lost when we dealt with the clocksource mess. I'll
> re-queue these, thanks!
> 
> --
> Thanks,
> Sasha
