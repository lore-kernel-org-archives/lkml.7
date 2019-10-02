Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E1C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076A6218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F0ZBUFy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfJBMMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:12:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35762 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfJBMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:12:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x92CCRQs082861;
        Wed, 2 Oct 2019 07:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570018347;
        bh=BY8geDIzMt6+Ioryuldlxg8hyLYttBQCYwF+MAIrCvQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=F0ZBUFy8/WJo8ehdXp3ee1h6ElZ5waQIoVQBnQL8DibGXbGEEjmsyEM+1R+0rHh5H
         8qpzS3UL+wLIslPqMA6GvgMmd8W+pNWBgaSmh8Tb5nMtcixzsbcp7D28Iz+wC8vCSD
         dzVSUFrgor02Mso2bB50ti1sBqh8xZ7qh3RRR4GY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x92CCRxR078079
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Oct 2019 07:12:27 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 2 Oct
 2019 07:12:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 2 Oct 2019 07:12:27 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id x92CCRVp014399;
        Wed, 2 Oct 2019 07:12:27 -0500
Date:   Wed, 2 Oct 2019 07:14:38 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hugues.fruchet@st.com>
Subject: Re: [Patch 1/3] media: ov5640: add PIXEL_RATE control
Message-ID: <20191002121438.g3re6v54q4hit2wv@ti.com>
References: <20190925152301.21645-1-bparrot@ti.com>
 <20190925152301.21645-2-bparrot@ti.com>
 <20191001075704.GA5449@paasikivi.fi.intel.com>
 <20191001162341.f2o7ruar2nifl5ws@ti.com>
 <20191002075951.afp2xligspqat4ew@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191002075951.afp2xligspqat4ew@uno.localdomain>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Maybe, I miss spoke when I mentioned a helper I did not intent a framework
level generic function. Just a function to help in this case :)

That being said, I re-read the thread you mentioned. And as Hughes pointed
out dynamically generating a "working" link frequency value which can be
used by a CSI2 receiver to properly configure its PHY is not trivial.

When I created this patch, I also had another to add V4L2_CID_LINK_FREQ
support. I am testing this against the TI CAL CSI2 receiver, which already
uses the V4L2_CID_PIXEL_RATE value for that purpose, so I also had a patch
to add support for V4L2_CID_LINK_FREQ to that driver as well.

Unfortunately, similar to Hughes' findings I was not able to make it "work"
with all supported resolution/framerate.

Unlike my V4L2_CID_PIXEL_RATE solution which now works in all mode with the
same receiver.

So long story short I dropped the V4L2_CID_LINK_FREQ patch and focused on
V4L2_CID_PIXEL_RATE instead.

Regard,
Benoit

Jacopo Mondi <jacopo@jmondi.org> wrote on Wed [2019-Oct-02 09:59:51 +0200]:
> Hi Benoit,
>   +Hugues
> 
> If you're considering an helper, this thread might be useful to you:
> https://patchwork.kernel.org/patch/11019673/
> 
> Thanks
>    j
> 


