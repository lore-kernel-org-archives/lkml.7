Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C03CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261FE233FC
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPwLuJUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfHUMq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:46:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52214 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHUMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:46:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7LCkHbe046774;
        Wed, 21 Aug 2019 07:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566391577;
        bh=zCH18eYlYmUbe/C+1hdcRyD18v/ys0bFqDGYxv33u8M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oPwLuJUkmA2KdBsvqRf6lvISpX0KNll+XMG6LsgBNXB0wkGO7k0sT+kd/KNAKFHKT
         leLREWasX/Hqsbdq7y+3mkoctLuBIKWjpG9kl9kriOBzgv2c1K3TYRj5zucIzAZeuk
         kJtsRelQ/U20BCnaU3PUPEkCTSl2he1ybr1Og2A0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7LCkH6L131020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Aug 2019 07:46:17 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 21
 Aug 2019 07:46:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 21 Aug 2019 07:46:17 -0500
Received: from [10.250.95.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7LCkGOq106386;
        Wed, 21 Aug 2019 07:46:16 -0500
Subject: Re: Status of Subsystems - TI BQ27XXX POWER SUPPLY DRIVER
To:     Sebastian Duda <sebastian.duda@fau.de>
CC:     <linux-kernel@vger.kernel.org>, <lukas.bulwahn@gmail.com>
References: <92d7646f-5a53-95db-d179-45a95c621c43@fau.de>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <ababb091-f598-5f68-6f6f-d5d90023bd79@ti.com>
Date:   Wed, 21 Aug 2019 08:46:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <92d7646f-5a53-95db-d179-45a95c621c43@fau.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 10:00 AM, Sebastian Duda wrote:
> Hello Andrew,
> 
> in my master thesis, I'm using the association of subsystems to
> maintainers/reviewers and its status given in the MAINTAINERS file.
> During the research I noticed that there are several subsystems without
> a status in the maintainers file. One of them is the subsystem `TI
> BQ27XXX POWER SUPPLY DRIVER` where you're mentioned as reviewer.
> 
> Is it intended not to mention a status for your subsystems?
> What is the current status of your subsystem?
> 


'TI BQ27XXX POWER SUPPLY DRIVER' is a driver, not a subsystem. It is
part of the maintained 'Power supplies' subsystem, hence I only review
patches for it, but am not the maintainer.

Thanks,
Andrew


> Kind regards
> Sebastian Duda
