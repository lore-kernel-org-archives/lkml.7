Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3AF22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfLLLYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:24:02 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfLLLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:24:01 -0500
Received: from [192.168.1.155] ([77.9.34.244]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfpGL-1i4P3u3mnJ-00gKKo; Thu, 12 Dec 2019 12:24:00 +0100
Subject: Re: [PATCH] platform/x86: pcengines-apu2: fix simswap gpio assignment
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
References: <20191212111507.14365-1-info@metux.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <79f8f45f-98a7-c2c6-068d-82e339d8be46@metux.net>
Date:   Thu, 12 Dec 2019 12:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212111507.14365-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CZeYZiiSBZWPrSOZTUvcsXeGgSQm2AkN673/yNAHOcY4QxiosW+
 12gZ84yQMb3aimeGqaU597g+KlRcOwqdwoYonPzz/KUloKV6JTg65LVdymneM/4xr4T54mt
 2MDte5OJWdZfuzW7DOST2qkFmHK/cmWRhdly+6ArDJuBWV7AkHrKnD58luIy/CAkcbeJt1b
 GEo6zal3745T7iMJ2xQOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vGHnqnB0WNQ=:o/gYaInETCt2ny8i3AKVBY
 eIZ+z8DoDQ5X02eEWeK3SRbu7vRT6A3ZQinp1tOVMBpWGoJhtsviBBrzyXOnfyJNUWxu2gfkr
 MCpHx4AqLnt16f4JPu9WZ0mHh0gEyZbl72b0hSTmrCSgNS+GFIvJ6oPc1+Nh6R85lm9pkxMZe
 NXKANIObVmHskLohuMNYiC6nicIl8l3DWIAbAfNcbX9i2raKk99iJdHmGNmoZdvB4e3O+BoHX
 YA+1EJRbEtoRPZs2ivpIINpuZ1iIJ5jCewfb7SekTItXTi8vJbaVBY8Hnt4YFAmX1EC4Pp2O5
 zAIC+gIsO1FBWwg00zKZX/4dHE/kjtpzYVzHGI9XwmwtlsMKpzHlt+HrZ/8sM6pu/lS71lbrp
 UkPRbt4xITUfIiMxkDvksQEogkcn4HQKzxBYqAVF6mNJW3S6XZBqLuuxu96lTtBzQz+JvLryp
 gb1/QkWgCki7cnYIfVvWXxISQR/tK5BniTbJsPPujo9e5DT7qaBIbSDWKZAMDjpDu9of1lZgp
 thtrzz5AbP2oHtMoa/o9g337em1GywmyLnyGl1yWewqrbQXZfS2sduMl/US299/nxt+H72+nK
 VA8+Mbit1yJei1WbyA0lookkctTk9yVVCD4+shYfAcWbDF/OQ/S4SgVbIJaXWjOq0mV3XK4O1
 r6PPxAAdxevMdiTsJUL9+nuia0lql7wcYuNv5fmL0oiI4TuLlGJh4x5HUjSZ01A7ehL6IqMbC
 HNL0tvHJTnTFWx5MBBgxTHcGKcjcElRbU2ZKpOH3G5qhY0/LhL3RL2xnocb9II4wSvNzynVsy
 JzldVSmPIuPL9OjK3kALBCvEJXiaASZ6oIJqe37JZbkuHworsGr2H/QvaNjkQpA32KPDt/cCC
 qbx6ORFXzpaV3JkQpORg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.19 12:15, Enrico Weigelt, metux IT consult wrote:
> The mapping entry has to hold the gpio line index instead of
> controller's register number.
> 
> Fixes: 5037d4ddda31c2dbbb018109655f61054b1756dc

Sorry, got the Fixes line wrong again ... forgot to fix my scripts :o

I'll repost in a few seconds.


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
