Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D9C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7B820674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dxf4l3ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfKTQIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:08:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:54305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfKTQIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574266118;
        bh=VPRug7+HSvbebtgoesxzkq1RJlesAxyAx8j/x5VtNyg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dxf4l3ZN8XUjfHH8AbAqsyZhlekVfmnGyCnTVgHPin3nZ06ejiZCbnHY2yoEdUPT7
         Q7U4b4vQ22JTjkv7rRPZq/pec/GxA5PzyN2aDFJQJCBdnTlHjlWiwCTMKPuQB/KF1h
         tarE9TV81aqIJlBMFhRS8i/oEy67zba7NnXCiTjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.139]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1i4iMx2LpR-00p65W; Wed, 20
 Nov 2019 17:08:38 +0100
Subject: Re: [PATCH] staging: vc04: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
References: <20191120133848.13250-1-krzk@kernel.org>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <fc808b93-92e6-cb31-0a15-8ed6faaae536@gmx.net>
Date:   Wed, 20 Nov 2019 17:08:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120133848.13250-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:mJp9UTjNGlEn2Z9Lm3PI/i9DsBu8E5pTB5Ml1bLGxLw4BfCwyiS
 dhcR3OZBNgQBR3ZrZt50zbmcEWHU+ic26/yqd/tQWfKf4mWH6dByZ6yOMv6knYJvCrPE890
 MpxiArxCaVWBUuK92eedfZ3swDJX8GVpwfSL2YJ1cvoGoaHFdkWqtN6ATM+GGbIq9vWjv1S
 526Jv8JC6V0Z8zvB7vZMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vw8G8SQOvuw=:DUT5v2eclXHUpOqZ4iBzf4
 /u2biM6bLky+V2Jp3MK04MHdqMvBCNAENqpteQHosqNo6VmY14+UBag/2wYohIlR+A2s2+jEO
 yvyrbuK4jIKOSIbXnTAlSqPG+zPohSoo5Fdl9XEs0uAUR4j3G2o3apzW/TPRcQrsR4enLM3fb
 eK8tLxepDUyM+a1j8i06RMeUMm/VDuS+xetFTmlITjS4itjKJJASXSn+0O0BknJJTybcIkSiP
 O6+mdOIHmvqD3jogPR1Lq2HAFdl0f/7wEuZTIdzkBJ2H7kDo9gst49n/74GhWmJ5qLsgAGxXO
 PfYu2aTMW8ym5uj1vEolb771duiJLGOuP/b+cZ4wuAzKJ+6fH/cwW2XAzalZ5I7iVb6UDMnUG
 vgxk1nKarRsG7OhAJq8t0VX5V5DRYUhZ7AWbVs74YAj1vhufhNp3oJHzPnNKYj4ToMcE+QtV6
 KspU5j1RYBVAx1O3J4z2Yyxv5xUnNS2iq5d8l1Ab9KUHWHn/pFZqRg+aAqAgcQgGWTrGLtnVg
 0hik4dG39IzkAaMFh91Bui76oN6cOkmzQjaYWh9d+wF4xo1xaS/p+7xECUVHPwxk2GcMuland
 aLrut5w+B1uu9gqUZr29M0SSXGXOD0fSSMQrV7fkqRNd2HjOWgJ+cc3pFApwlKLOd5ZdMvj8e
 w6q4v0us1fFUOO9vBmsNGYcMuRJfMe85mK3UoVKy+edfAuB4shXECpl9ebkhRjF8uo7EHKFzQ
 D+SmClymQ7kBLCW5sXFgt9GZG980BuKctZmmmzC1UbOlFmxUklYds5ZBbTz/btgEMHo50bC1/
 hvApTYqOFWQv2QbOOGL9/NKIi660eXA7TXsXAMsapNP0w5kFnHrywfUu4kVbvqVhmxFQarlbg
 wu/fFMyG8L1teQo8cScmK0QWVb4QJkbeIO2VGkpTLHD1vXBLn2uAq3Ac/d4BZHFZRBInOCOek
 eOfhiVzW1ks1Y+SFNCwSJYF/wzOqQHd4uJ0TQyKJKfZ9fBdxGWYoPh/tEFAfrkTAvmK2xsg8G
 0OTm0qCx/NEoDnkdOa12umm0LZ3MvmQp7ifNlEALNL4soV44vTdOqZu04SYD+myc0TPE2Azk8
 BR7RvQL/yzFe+0opD4rrAHP65qR8eHqsnlmxat9YJfq+ikGKUcL2dZ4EBmi5xBj8HO4e9VkqL
 j31KYmDyG0m3rdvuHhceYkuqwck4waUZnIlQUwslLAW1iHCC2Rnrp8CXbQ3LVJo6TuSmFbd7h
 LFJcRCCLynwfOJpNjPSBq10fWCLK45hrLoQXRBiZ+CyWLB+APvNmw/HfcO5g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.11.19 um 14:38 schrieb Krzysztof Kozlowski:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
