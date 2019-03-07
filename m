Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46982C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA61205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="C41/XX6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCGT7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:59:55 -0500
Received: from vps01.wiesinger.com ([46.36.37.179]:55716 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:59:55 -0500
Received: from wiesinger.com (wiesinger.com [84.113.44.87])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 55EA69F2C4;
        Thu,  7 Mar 2019 20:59:51 +0100 (CET)
Received: from [192.168.0.14] ([192.168.0.14])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id x27JxZQT027889
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Mar 2019 20:59:43 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com x27JxZQT027889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1551988786;
        bh=NmInnfckcqZjrCeA7F6dosegv2xqiz+HUoc7V+WYmFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C41/XX6I7BKtYRPe4BxuKQVQC9ew0sSjt0V7DjU8bZuFopAr1IUwvxbZ+N62XMdor
         YhrtqhKjc5LuZhC7MWt17xezuCyhRo9X4sb0xwSejchbvTf0dKYAPvRTAZwpVeV6eT
         aCIgGEcSbVGUyxZUj3xk0LnJ42NazH4CVOS8VT8ii4c1uF8qG/wulEay7LOLLoyJGK
         GUjq476024r9Jjxx1+cg3oVRmeA3CgiWcH/7dez/ob4Mct41oXrP4xcicYlKboVefO
         9FKH1Ia1IO3/iPYyjrDnxkYvdTSJ0JYaeVaHP14IXIZ7VRJJwT/KiGFPlgBz5e786L
         pYWorlRZ2MC/4KgPS5VMzeqR3s7bnEvSr9or+WBG8+kytA3ZVh7oBJ45bndpsOx9Bf
         j8iifuyoE80BUH9amtdHm/a1xdkveJGH3Ljve8yDcMldyWjWPOwLQLHghN4gFvqeA6
         R0J5q7+jujcql37qI2hNbypWMj4MJ0uYNN0lyWA6JtkfUCHZ61Ip5/D9rIzGdZ0uLb
         GCETnkO4oiGE78wGQZwULrAMb7QxRQ3ivX1cHTv+pgLnZZKvD7qJr3lVnpJYgUVrN2
         1GBmL6zU8c+EQyQcQGptzrbMfLb8OF2Y6awmTeFkHl6u2+F4gYgnYyZTm1lC4m5kEi
         zRXG5a0akRAyLw7sHm4tnbio=
Subject: Re: Banana Pi-R1 stabil
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
References: <20190227092023.nvr34byfjranujfm@flea>
 <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
 <20190228093516.abual3564dkvx6un@flea>
 <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
 <20190301093038.oz56z22ivpntdcfw@flea>
 <8ad8fbeb-fad8-d39a-9cc6-e7f1deab0b4f@wiesinger.com>
 <20190305092830.ef45kxzhdnxlh63g@flea>
 <9f189569-bf76-22d2-3bf7-db710f616998@wiesinger.com>
 <20190306073605.modlx4yhdzbg7sfz@flea>
 <34300c49-fe89-77cb-444a-f6de02d41a62@wiesinger.com>
 <20190307153103.hsckxwzg2ypckicy@flea>
From:   Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <08655ad4-a144-a3f4-9163-c4268be0aba3@wiesinger.com>
Date:   Thu, 7 Mar 2019 20:59:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190307153103.hsckxwzg2ypckicy@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2019 16:31, Maxime Ripard wrote:
> On Wed, Mar 06, 2019 at 09:03:00PM +0100, Gerhard Wiesinger wrote:
>> while true; do echo "========================================"; echo -n
>> "CPU_FREQ0: "; cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq;
>> echo -n "CPU_FREQ1: "; cat
>> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq; sleep 1; done&
>> ./stress/cpuburn-a7
> Run cpufreq-ljt-stress-test
>

On ALL Banana Pi R1 I have and Banana Pro OK, see below


Ciao,

Gerhard


./cpufreq-ljt-stress-test
The cjpeg and djpeg tools from libjpeg-turbo are not found.
Trying to download and compile them.
Downloading libjpeg-turbo-1.3.1.tar.gz ... done
Extracting libjpeg-turbo-1.3.1.tar.gz ... done
Compiling libjpeg-turbo, please be patient ... done
Creating './whitenoise-1920x1080.jpg' ... done
CPU stress test, which is doing JPEG decoding by libjpeg-turbo
at different cpufreq operating points.

Testing CPU 0
   960 MHz ............................................................ OK
   912 MHz ............................................................ OK
   864 MHz ............................................................ OK
   720 MHz ............................................................ OK
   528 MHz ............................................................ OK
   312 MHz ............................................................ OK
   144 MHz ............................................................ OK

Testing CPU 1
   960 MHz ............................................................ OK
   912 MHz ............................................................ OK
   864 MHz ............................................................ OK
   720 MHz ............................................................ OK
   528 MHz ............................................................ OK
   312 MHz ............................................................ OK
   144 MHz ............................................................ OK

Overall result : PASSED

