Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2454AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32E220879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfEMGtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 02:49:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:49293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 02:49:38 -0400
Received: from [192.168.178.187] ([109.104.40.7]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MD9Kp-1hYdLQ1ZJ3-00985K; Mon, 13 May 2019 08:49:17 +0200
Subject: Re: [PATCH] staging: vc04_services: bcm2835-camera: remove redundant
 assignment to variable ret
To:     Colin King <colin.king@canonical.com>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190511134813.5645-1-colin.king@canonical.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <5fd5c89a-4bd0-1d2d-f027-819fe954bd5f@i2se.com>
Date:   Mon, 13 May 2019 08:49:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511134813.5645-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:6gjO/x7pdDWHJchMfTFoYpMrc2jCJwMLYflU4Gu8ajN8J46umg6
 aMe2yCTYt5dfh5L90OffWgr+De4ZEbH7zWOzULis8Wg7jHu11WCzgZWtKNKPAptARDx0oJ0
 onjJagH2RY6NH+NAetYiMMsie9qoyv3MvH4KUKzjZocbDIdCRjsjk1SFU/5wxaBPr4iNuWQ
 hQtDghl6UxoBPf6cQUayg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ATE5Qe06IYI=:LutzhZvoFJqtjnVznCcyii
 tuxoWieuRi4pbG6k9Au0IJ9Ub5XgOXfj1MY0QsBkBbMXSbDvguUogyLLnjeSwNGOsWeOMjvSM
 8AkIDckWw+Udpaq5coHqFCoxBKcqTR7tymRibv5jN5rdQTe4mOvO6FD6Cxvt5xk9taq/JjZJn
 jrCvrFs1sK6T9EdG8v0Adu8/TbKi8+UV9AvAIDXtJsnDHMeen1p5PYYLP3xRp86bo2osT0NzL
 gjEeHhxxREkPSAG3zyCYMeiMMgdOtvFpoiT6gStg5XSWBLCinF8NVQh91n/7yl/bddj2JjWGI
 8fmMZFsL4MKtdLf4SBPlvPfx26E8QaGGPnL5CVeqqT8v7UsY2PpUyh05QtzsXlem2TNnGYdtH
 /b7eub9w1KSlYIAhLVUN41vJBSQGjgKWIgUav2Aim1M4Dw7uND/9bidkmVIKu3A3z4lY3OQoZ
 rDIu0sAWbt8ZzTOf3H2ERZPU0gDkDtxPV602BDNE2JIIIdO0+iThd7fQntiBQXFljbxxLj6ZY
 SdEZ1f6CfX5ji1ZM3gHrlI/hMwZXuB+NOPfSOzXYSAgLOPhbU2wXA6d5Vw+g5A4k+zvp79plc
 ZilfIzGQj5RS7eD1od8LSX00t9D0pz+yL1Ue+1Xvs/ALaEkzKRnnV/oo6RcUd4VeZ6MvUlMiD
 1akkc4W8Sn/78m4OlWg088rvmNW8BJ9j+uUosZe0QQWCqFvYXJ9YTIICv0weU9AAR/pn8B25i
 R7N7C825vhSBDGmX7QLdXGT7S6Vx3XH2oT5Ig3b8K9XyfNS5TXKSbguR/3Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.19 15:48, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized however this is never read and later
> it is being reassigned to a new value. The initialization is redundant and
> hence can be removed.
>
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
