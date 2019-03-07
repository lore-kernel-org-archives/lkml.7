Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E09C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF04420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCGVEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:04:05 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:56461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:04:05 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtOX2-1goBcy14Ry-00utQJ; Thu, 07 Mar 2019 22:04:02 +0100
Subject: Re: [PATCH] drivers: leds: Kconfig: pedantic cleanups
To:     Pavel Machek <pavel@ucw.cz>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        linux-leds@vger.kernel.org
References: <1551896146-17719-1-git-send-email-info@metux.net>
 <20190306211914.GA355@amd>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <eae77715-ec42-ae26-3b77-300c32c329f2@metux.net>
Date:   Thu, 7 Mar 2019 22:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190306211914.GA355@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NgY0BlhE1kkv8Mq4nOXZIzjyObVyPVryFIFb7h9gnlDHFvpPnd5
 XzhFWwrmxFQ8foMUB/l+vMaTpIz1wud1VK814JaDDxERa4vXGLAn9cqZnw5hwz2PqS3ZDSD
 6d9T7lfW5z05cKAgDLhasnXAWCCj/syZ15Y+2BKUvCIOr9/OvjbXYSr50IkS8bDue9EZgfh
 i0bMc4CeWV5nZDn1pqIRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r4yiLZFbkX0=:2VcBxk8PI0bAUvRLU0atCy
 aJ5LW+iaVtkDAtFkI+mhWW9MdrjuGFHyWNaWMYkOKCFOtKX5+s30NhbHaHYVijkrmrbPb9y1i
 PcdfRqXPwrqonVywJP5/RuE8U6dAr1xlF0x3Z0x379M+0hZAiDDj1+nRhpShYoYJC+DCWFLba
 wJv0rwYhLjVhxd5N5EHi7OYySmbTV+WVznZ1I1DS3pLNjFZZRZg1dxZX/00glL90s8xeDVnjf
 9Z6yh+RDtwF86T0dMqXyR2DLGOey0PBITJQEabzlsB3rYX7KzInX/oBSEylBqQCLkFVdtxt2T
 354brzAX/F4YTxeDryU3CZgEw1Gnpc8ncnwPDnEbSCKF7ln4RpO62FCLB4k/IK2FXu746gjoO
 NNAOR2pXKXJYBX9YgN4szSXDEueYVIOxmUVCEgVg3w9bbYBNNLSjif132epzwYq3GchO0chPM
 Nd5IfNs0K/9IzXBNXp3heVzXbVgwjqsajf7vJRpjLL6msKmR5DY21cEk2ogm4/eXQcyvYw43k
 7cj1zY2g56999hYgJPPm3zabAWbNMNDEzyy6ZokU0fwDzvr+C46OBXcSm2v2nWw07oRBCJssF
 QAi8QadzCqmMilkEhroPS3ZHJwGCjjF+ThTCcbyRDtgUaW5/SKpRwMh1WB5Zsb7EPAsCgW1Ll
 5JdrKdXgRiW3Tgh1/4lzS0dCCBykYS92kIouSBic0B8ILhdNhwl4Z4gCju0Kbre0yn3aK+gwj
 ybNl8Ho3OiZGK8cgbsjuGzv8J2rig4rBfIrWVcFrxmdaNPpiPhyl4N3DO0M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.19 22:19, Pavel Machek wrote:
> On Wed 2019-03-06 19:15:46, Enrico Weigelt, metux IT consult wrote:
> 
> Would be nice if changelog here said what you did. AFAICT it cleans up
> spaces before tabs...

I assumed that would be obvious (my editor explicitly shows tabs) :o


>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

thx.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
