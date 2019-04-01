Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898E20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDALKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:10:31 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:42289 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfDALKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:10:31 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id AupZhggQGUjKfAupch4cnI; Mon, 01 Apr 2019 13:10:29 +0200
Subject: Re: [PATCH 0/2] DCMI bridge support
To:     Hugues Fruchet <hugues.fruchet@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Mickael GUENE <mickael.guene@st.com>
References: <1554111076-31471-1-git-send-email-hugues.fruchet@st.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <158aa8b9-e607-3630-0e13-ad10759d3468@xs4all.nl>
Date:   Mon, 1 Apr 2019 13:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1554111076-31471-1-git-send-email-hugues.fruchet@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN1SDN2vVlS0vIB1YV04J2Muzu7kueOPK5m4hj8hqzkqEJW/ArLSBThXVZcnaF3JAkkzLJP4uaVYIMGTn7w4PJZi6h1J98PKH8RMr3eA5taWXDWrOJaP
 mv+67TXANR25gUxYWkvoZIV6Of5xOfGu1AdPkokwEy8YxYljxHXCQ1k7ckXRy9rmjMs/LXaEpFaZAVwbL+lvaeTViqZsFJlzdLnpwb2MEyKVz+fN+RHa4jZj
 0a5skxVHDPq33IDMGPtgpGSsJc3Vi1vYrk6Nlpamb2j5aEtksbjkCwLS7bNFHdScnA9actVQLY6ov5oQa366x1P9ejdlULls28VuENwqKEh/rENp2iJB6omS
 0P39yTlmzYhRfWwco/kydW066tgedB7E8qhKip+X9t1UzwPFf8Y47DbaTFjgEYPvF0VyP0Nocllohkqw7c6drZUvTuwfiFvd3TScr6S6+OW8DwhCTSTWqLb3
 JGutjSw8oMQkDJ44TPtE20Pu21ubGjuW+iptiljSr4Qfjp3z0NRlFsW8+InshklOSB+3vjW9GPR6f86S9ImG3SvMDckuO6uiW222Gw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues,

On 4/1/19 11:31 AM, Hugues Fruchet wrote:
> This patch serie allows to connect non-parallel camera sensor to
> DCMI thanks to a bridge connected in between such as STMIPID02 [1].
> 
> Media controller support is introduced first, then support of
> several sub-devices within pipeline with dynamic linking
> between them.

Can you post the output of v4l2-compliance -m /dev/mediaX ?

Thanks!

	Hans

> 
> [1] https://www.spinics.net/lists/devicetree/msg278002.html
> 
> Hugues Fruchet (2):
>   media: stm32-dcmi: add media controller support
>   media: stm32-dcmi: add support of several sub-devices
> 
>  drivers/media/platform/Kconfig            |   2 +-
>  drivers/media/platform/stm32/stm32-dcmi.c | 213 ++++++++++++++++++++++++------
>  2 files changed, 177 insertions(+), 38 deletions(-)
> 

