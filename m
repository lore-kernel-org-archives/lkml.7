Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9248DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD082067B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404658AbfIIMDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:03:38 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:48752 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404215AbfIIMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:03:38 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Sep
 2019 20:04:28 +0800
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
References: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com>
 <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com>
 <be032a85-b60d-f7f0-8404-b27784d809df@amlogic.com>
 <CAFBinCD7gFzOsmZCB8T1KJKVsgL7WMhoEkj3dRzyqwAnjC0CNA@mail.gmail.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <a82336e2-44df-5682-1c86-daf8a8448d30@amlogic.com>
Date:   Mon, 9 Sep 2019 20:04:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCD7gFzOsmZCB8T1KJKVsgL7WMhoEkj3dRzyqwAnjC0CNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.226]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 2019/9/7 23:02, Martin Blumenstingl wrote:
> Hi Jianxin,
> 
> On Fri, Sep 6, 2019 at 7:58 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> [...]
>>> also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
>>> aren't there any busses defined in the A1 SoC implementation or are
>>> were you planning to add them later?
>> Unlike previous series,there is no Cortex-M3 AO CPU in A1, and there is no AO/EE power domain.
>> Most of the registers are on the apb_32b bus.  aobus, cbus and periphs are not used in A1.
> OK, thank you for the explanation
> since you're going to re-send the patch anyways: can you please
> include the apb_32b bus?
> all other upstream Amlogic .dts are using the bus definitions, so that
> will make A1 consistent with the other SoCs
In A1 (and the later C1), BUS is not mentioned in the memmap and register spec.
Registers are organized and grouped by functions, and we can not find information about buses from the SoC document.
Maybe it's better to remove bus definitions for these chips.
> 
> 
> Martin
> 
> .
> 

