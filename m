Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C16C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F045020640
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfIIQLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:11:43 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:26745 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfIIQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:11:43 -0400
Received: from [192.168.0.108] (223.167.21.35) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 10 Sep
 2019 00:12:33 +0800
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
CC:     <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
 <1jv9u1ya3o.fsf@starbuckisacylon.baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <b8350c34-1fcc-76b8-6722-1e3309089c04@amlogic.com>
Date:   Tue, 10 Sep 2019 00:12:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1jv9u1ya3o.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.167.21.35]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On 2019/9/9 19:36, Jerome Brunet wrote:
> 
> On Sat 07 Sep 2019 at 17:02, Martin Blumenstingl wrote:
> 
>> Hi Jianxin,
>>
>> On Fri, Sep 6, 2019 at 7:58 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>> [...]
>>>> also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
>>>> aren't there any busses defined in the A1 SoC implementation or are
>>>> were you planning to add them later?
>>> Unlike previous series,there is no Cortex-M3 AO CPU in A1, and there is no AO/EE power domain.
>>> Most of the registers are on the apb_32b bus.  aobus, cbus and periphs are not used in A1.
>> OK, thank you for the explanation
>> since you're going to re-send the patch anyways: can you please
>> include the apb_32b bus?
> 
> unless there is an 64 bits apb bus as well, I suppose 'apb' would be enough ?
>
There is no 64bits apb bus in A1, only apb32. 
Unlike the previous series, For A1 and C1, we can not get bus information for each register from the memmap and datesheet.
Do we need to add bus description for them too? If yes, I can add 'apb' .  
>> all other upstream Amlogic .dts are using the bus definitions, so that
>> will make A1 consistent with the other SoCs
>>
>>
>> Martin
> 
> .
> 

