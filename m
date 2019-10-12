Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EFDC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340EC21D56
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DwTTL9LZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfJLRKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:10:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:36599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfJLRKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 13:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570899908;
        bh=WThmjchEV2vzAfou34wsoexJ0904q7Zea1RHmt1M0OE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=DwTTL9LZ/P3ZtHGHGrPnmR3fUQTLV35vGi1ykO4JnzH+4YSoWwCwENM2WQX5FDRdI
         M/K2VsaTpxQkH72xRvvoS+kEUHbG12FEnAmKhxwpe3E5VBNzwPoAtWd+k1YoOO8GEp
         aFmq1tvoRqZCNXwb85mNaV8BI/arkoyKXEWptrqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1iURhc069Y-00Sbmb; Sat, 12
 Oct 2019 19:05:08 +0200
Subject: Re: [PATCH v1 3/3] ARM: dts: bcm2711: Enable GENET support for the
 RPi4
From:   Stefan Wahren <wahrenst@gmx.net>
To:     matthias.bgg@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191011184822.866-1-matthias.bgg@kernel.org>
 <20191011184822.866-4-matthias.bgg@kernel.org>
 <dfe9062b-1960-f67b-2a9e-864c0680f5d3@gmx.net>
Message-ID: <bc741ef2-64aa-562c-69cc-f787b35c1058@gmx.net>
Date:   Sat, 12 Oct 2019 19:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dfe9062b-1960-f67b-2a9e-864c0680f5d3@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:TOY8axM0tJeh2ZJQi9bkb+Z/Lu9KtfC8Aq/2aZuGRApGXwwMKVT
 DsmnYbDjr/1UDJ5oTeuAK8MgubkKE0RJNoIuEyqYT9L3NckFkQsWrgUzysDPWsLmkCSTuer
 wGwsyt62YfRmKgYCA3bSLh6SM3vgSGfKWRX8E8sRaG/+5lAL+eonlZmJ/lVOXUmbTsC330H
 vsbFJeUNXCi0+abkU+CPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2MuRQWHyKLs=:IcfwFc4ZLH+uLpnNutppBy
 iVDysOqZ8lvADJrDHiUQrak2+buixxUIYJp045C7Pc8Uq9gJVtq5ngEZc1shkKGHG8COkQ9Cd
 fCQBrAjRd2uTXcravu0eM6c5ZnIxEYiFFFBQMHvGA5PwwkdH5PAOQzE9qB9XU5sYSg1aHxMZI
 OcPFNIIYoAl4zjfTFs3ap8EhMSdaC9u58LFRTkDmEPOCYO/RFT2ce0SMgav3xI4cHRvID0UeW
 vRxc5ierCN+cHPTiaecN9qRsMiRwhsj9TTvrluGa+lKvnOaZNxSC3puExNlktTtuxy8hf2gzR
 A4QZ1DSXgfk6BrQ9dNWkYP46LiSQz8MT4zvho2hZyuTyqOyuAP4IOKl/8BEcznbxxFmwwTDyE
 SiPoV/Q7VqQqVaPdL4el7hCtjbMegzzCYoOTKuEhhnn207dFSa+Wu9iTP5jOu2l7FmBbiClqC
 PALbFAJ+1EjMKqlF2iflm/HTLXBWhTNmmQIiHtFjbRINBQ7eCu5QE6RE4NJ+6YJmkfxy0XxTq
 tHabEciCXCVWcuyW33U9nu0F/5biV3DNmEoIKIwJGPtVqOQg0Hn6QBBtoPjA/Xi+TlCYEHy5J
 zMScV4SdLyM+RIwzeBH1Aapb3MOmHkASGFWlexXYaWIuvZ8PLO3vtMb8zhLXHH6AB7hqBFdix
 jebEUQYZ/qvHDDBbHSff4gL0Q1r5KquYbjtxRnz/Emut1FpdHlw4WFynb+cXklmbdpTuD7miy
 bhN/gK/IpDOHP6lWikd1iFPE5sqFNQDRLLGNIYvSWciwdqUvo+xAcmFIvGLVlQw/gkk7T+Rba
 7s9Ih5b3QfOuAjCaz3Oqfd9ChesR3g6Pu+i71ygJLtp0oWyqHtqOhQYr2/cj9Z38fkQbbxKAc
 pAM67Yl1ppvecGWIcOPPLj9WhV6G1WrMwlygtexgUF/ViEOX70J9qU6NrBLARBioRQ3xNIp83
 iI2wYYm/E8UFdBOekrdkp2x9LYn/bSkWYZKLrNZBd8MhkoclBdOS8RFhvKx9PHkOinRYmSckc
 7MX/X4jAWmXNrnVp4djip/U2/Y2nEhbtC+pQzQxQ6jOb0gsUrFALjGmmraVFZU4Z+m+S5X9Be
 epNbwCyXAzmSMwux/n3qs+rARBD2Mf5Wa0dT4BJ48VsXJ3VsqGLtJFVZzTx2P+SQ2IZ59/H7w
 QLxwLPUYu+b5O56a/8SvKTHF0oCLVvLyyNyq1V+4Com7jUw5/pJm1K+orGOgMF8q6f60NonjV
 w9Hyqu23kHQeAIHEjlZmQ2Opr2nC1lBV88TnxkLOMcxJowPZNUp+hmxtvrNc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.10.19 um 01:09 schrieb Stefan Wahren:
> Am 11.10.19 um 20:48 schrieb matthias.bgg@kernel.org:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Enable Gigabit Ethernet support on the Raspberry Pi 4
>> Model B.
> I asked some questions about genet to the RPi guys [1] which are
> relevant to this patch (missing clocks and interrupt, MAC address
> assignment) but i didn't get an answer yet.
>
> During my tests with a similiar patch series i noticed that the driver
> won't probe without a MAC address.
>
> How does it get into DT (via U-Boot)?
Okay, the bootloader uses the ethernet0 alias for the genet DT node. So
this should also be added to the RPi 4 DTS. But i consider the MAC
randomize patch still helpful.
>
> [1] -
> https://github.com/raspberrypi/linux/issues/3101#issuecomment-534665860
>
