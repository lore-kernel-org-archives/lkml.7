Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD15C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15DC217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbfGHTm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:42:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfGHTm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:42:57 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhWx1-1iNC0G2kWh-00eaLR; Mon, 08 Jul 2019 21:42:51 +0200
Subject: Re: [PATCH 2/3] platform/x86/pcengines-apuv2: add legacy leds gpio
 definitions
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-3-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <bf9c82c3-bc6e-b701-afd4-b4e657cb09be@metux.net>
Date:   Mon, 8 Jul 2019 21:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190704090205.19400-3-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8UZAoJ2cnJMqsaXzPuCfWX34iwNktO9clHcK5ez3G4Lz5QLzADM
 u7tdBR/4I1Cop5m78CVcWhFaouOb/q+7II0Dv1bJ+cDY31Rz27oFaf5d/rkf1LIkHcVjsKg
 E/O6pzJOl0UQhMIwcqBYqOWxHt1DG45crj1KLS4fDc2TnycYLfyvQlEf/sWzunSeRtFXM6v
 9Pa57Gl3Dz/xK24eA1YZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5UuROpRbtSY=:EvjEmtQOhMZt+Q0DzmDf8Y
 lk2IJZQGbxEnREjwdyk/tSbprkVbi3OeYPuUIZZVFAUG5G0B7RJk6ed5tNnnX1Etos9J8zxzc
 wFCP0XO0VIEF1BX6PIVrJ9R8xKzcB1r+7hRuae9l6vVbHCQnfxfv4vy0rmP7aPdF5Ee/K8eyg
 ZeITjDNUS5p2F37n52NgMWqo+Z+Zb+IGyzf0zEC8m8Ltyw7N5TLmyekogU0zVJb4FsiKFQEhl
 B6GnEVhb8qOES+SHpTvtD/7KATkEaxk0ux29DjzInlK96VEyfu6ZvhCy/U/WdL+TXBkSIiLuO
 3OgpHtU4oecEFWM/GxC/NMN6O+9Ic1XadxuWOmN3L5EsceCVnmFVMBjKuy19KDL4k4+G4T/5C
 32Uy0PoXytVk+nNyXYydzT1vJo4/MQ1Mijz0lZqSXh4GdZmxCGMbtmHg8YkxNqdq4YBjg4MJX
 11DzuNJ93Gg4IMr8ZpOuERE01gfipEbyiTIX7r/AlurjjWAmF+Y+tVx2OYswCJQx1j7Jysiz7
 2fYcqS6jzYinrHtHbxbdBXUuAM4hNQXmFnPpXwqBJJE+YJvRZR0ZvmC3fI8WkZMT8yVTuuftN
 6xithG9mqjhoEhojlOsKv0DHdzQND80iIiiffs5nduv/uYujcV8okQGMJ0Fjpt2j3V+zA2orS
 7gosZz1l1PpoY+wERuqTr04W/u1GD5Mm0tSE9f7Q1nKSKGSvV/gEba659DNICfGi+dIWs32TU
 W8KhevZqIBoFe3RnbM6C5Zg3NZGyDnY6WvzaPwNremMgNv/rxpOt/K1bEh4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 11:02, Florian Eckert wrote:
> Extend the apu2_leds definition to make the leds exportable via the
> legacy gpio subsystem. 

What for ? The gpios are bound to LED devices as that's exactly what
they are: LEDs.

> Without this change the leds are not visible
> under "/sys/class/leds" and could not be configured.

How so ? (I'm using exactly that all the day ...)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
