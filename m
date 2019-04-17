Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120D2C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42C7204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hS82YiJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfDQIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:25:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57418 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQIZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:25:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3H8OZJV029233;
        Wed, 17 Apr 2019 03:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555489475;
        bh=FPUnS8pDyt14xNbL/5rF/IvH6lXPW9R1XQtW5WrwmHE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hS82YiJM0hPv5Q7ecfU9UdC2Bf9GV2z9nCUwD0oXvQOKBRDfBftbMA22sbG7g19bN
         UuaLQ5Pad5xkeS/1gQ1rpcD8zuuQeuLSRmntuQAKMKo7gRKFcK+qyRF7tvF1lfm7Ng
         wYKGRGzXwhLQzNoMvgern9tJ0DFl41zZMkm+Lxb8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3H8OZtY005984
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 03:24:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 03:24:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 03:24:34 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3H8OUCD052386;
        Wed, 17 Apr 2019 03:24:31 -0500
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
CC:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190408075924.2284-1-brgl@bgdev.pl>
 <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com>
 <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com>
 <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
 <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
 <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b4ac6b17-2aa7-4b58-4cc3-969a9676e3e7@ti.com>
Date:   Wed, 17 Apr 2019 13:54:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/19 2:07 PM, Bartosz Golaszewski wrote:

> If we agree on the direction of these patches, then I can go with a
> single enabled OPP for lcdk (456 MHz) and all OPPs up to 375 MHz
> enabled for da850-evm.

Sounds good to me.

Thanks,
Sekhar
