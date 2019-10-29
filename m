Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD539C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8385220830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OF+PtD0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfJ2Le0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:34:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43790 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2Le0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:34:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TBYE6Y026265;
        Tue, 29 Oct 2019 06:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572348854;
        bh=RDinzMR4Ria3R4mBnaWd0juZSdCsUMS3GbDYK5lHLNQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OF+PtD0A6jilz+Gk9mhlGVOIboLizXeeBqNcNLDQCZ55L8oFwn1XcvqCAKNDeOzkY
         uriNa0eR/uDjp2xnFK46kFctySB8VS93SwUE1jQRA9Sw5fRvkmmQkVshsSWUFjHFJu
         MhO6Gnk4Djkwy/ZGrk0TmWs9HBaGizyoBOIDBC10=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9TBYE5p093662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 06:34:14 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 06:34:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 06:34:01 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TBYCoW061133;
        Tue, 29 Oct 2019 06:34:12 -0500
Subject: Re: [PATCH 0/2] [PATCH 0/2] arm64: dts: ti: k3-j721e: Add USB ports
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191028093730.23094-1-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d684ada8-5a98-b02e-be0b-c133e2f44b1f@ti.com>
Date:   Tue, 29 Oct 2019 13:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028093730.23094-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tero,

On 28/10/2019 11:37, Roger Quadros wrote:
> Hi,
> 
> This series enables USB 2.0 support on j721e-common-proc-board.
> 
> The USB0 is available as a type-C port. Although it is super-speed
> capable, we limit it to high-speed for now till SERDES PHY
> support is added.
> 
> USB1 is routed via on-board USB2.0 hub to 2 type-A ports. USB1
> is used as high-speed host.
> 
> Controller side DT binding is approved [1]. Driver [2] is yet to be
> in USB tree. This series is safe to be picked for -next.

Driver is now in Maintainer's tree.

https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=testing/next&id=387c359b84f71ca29c1a9fa24293c65a257f6bf5

> 
> [1] https://lkml.org/lkml/2019/10/25/1036
> [2] https://lkml.org/lkml/2019/10/24/371
> 
> Series is based on top of Tero's ti-k3-next branch.
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>    arm64: dts: ti: k3-j721e-main: add USB controller nodes
>    arm64: dts: ti: k3-j721e-common-proc-board: Add USB ports
> 
>   .../dts/ti/k3-j721e-common-proc-board.dts     | 35 +++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 60 +++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  2 +
>   3 files changed, 97 insertions(+)
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
