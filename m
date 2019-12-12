Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC8C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D72214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfLLK5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:57:53 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfLLK5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:57:52 -0500
Received: from [192.168.1.155] ([77.9.34.244]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAfpQ-1iYma71nE8-00B8Qa; Thu, 12 Dec 2019 11:57:43 +0100
Subject: Re: CONFIG_COMMON_CLK vs CONFIG_HAVE_CLK
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <871rtae1m5.wl-kuninori.morimoto.gx@renesas.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <741ff2c5-56b3-5ba0-3d52-39f77d468739@metux.net>
Date:   Thu, 12 Dec 2019 11:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <871rtae1m5.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jfkuNy7/fCi0rzXmELMflnyO9841JrTIse6j/+mgmnLvV+lkIX3
 fe4zzmfBIrxM5WfDvnf5SYA9f5OEyygYXXsam95zzASix8a32MCoK3iu2uyh72DEALHb2yB
 c4DIBb0gw3+atYWkzfzaxoyWjdFUDcsr5dMxRzSr1eKFNJJaG393GojSAjFovB4POB9/hI7
 oikSugWYZ/8hfxOgMcGDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8SnvJGSPurQ=:bEuYauAMSwkYBASfPgtM9l
 iRHu5yB08E1gfsAYnrl2q5bqeaX58GZ30PDNBq2KwZe0DYcdcZL1luYsWtF2SwmW3/nnc+Cff
 /HXZabwyTm4FO3MNyAL/K0djrr9sNbLfnQ0q88QmcFShaYSaHbi5kdSxn0AJC18lkIEyJ7i4X
 0R9n03xVO+BG+oWGqyal8a0kuU7JXg2MhTb/Ar0D+z4Bvs4P2Jj2+8EiMOn0gdfEey6PKHNMG
 HbUyGGcVfmbXY6kv7/ENdjU0pqwIO86Z5VypCQ4sPuGf5/wwzRkLyL3+kVnDCDbxXEQWylukG
 4C19DiGdHPhP3JELVzE3Cu/KpAzkw0Uju5Wf+kT4nhbM8JjpwUp1gRQG1SdJ1QSbHachabkgo
 2GpLXoQOIxSHDHx139wCQL37jqxl2qhT+9xC2KRcd4w6rYl29ZBI2GKq+itG3B4NYkDy7PYps
 eSfs9RbAQ+5EjxTKrsKJj9XHSHKsuFpr4teZ15uslY9yNsTSZe8jsFey53B0TX7VAw9Dh6TQA
 6sIz6DYuQPSFRtA9q3JcLdZIMcboJuW1bTvWNnOIi0qOqumTxri5xK5wIzsxXSzqorRYXePHq
 ciO+Z+x9tZtEy7fXkKufdeenaUo2D0d7I7KeadN5BqP9eVTrIF1foFN0FR/L5nI5WtrViz5hw
 e1+Z7II77RP+cMIZ10oCHwjH6t/1N6SrOJZyZ684Bu2t6MO68h5GRFRfbquDvFdnRz/ED0ay+
 A8TaFjxaBvFy5dg0S49a6+wYjgE+xNZxjxiXf8D2IwL2a7x7BCuHnexrVd+x3VwMZ7SYdq3wG
 I1mwh4sDQUs0lGt+BuOrYI1Sum1W4HVahSZsXNmQHfkZyHW95xKLsl56UyOiN0sXMVUa5XUQE
 UQZzri4cm8rzCTn+jVHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.19 03:09, Kuninori Morimoto wrote:

> I noticed that there are some CONFIG_HAVE_CLK vs CONFIG_COMMON_CLK mismatch.
> Because of it, I got compile error at clk_set_min_rate() on SH.
> SH will have HAVE_CLK, but doesn't have COMMON_CLK.
> 
> 	> ARCH=sh make allyesconfig
> 	> make
> 	...
> 	drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_target':
> 	tegra30-devfreq.c:(.text+0x368): undefined reference to `clk_set_min_rate'
> 
> clk_set_min_rate() is under HAVE_CLK at clk.h
> 
> 	--- clk.h ---
> =>	#ifdef CONFIG_HAVE_CLK
> 	...
> 	int clk_set_min_rate(struct clk *clk, unsigned long rate);
> 	...
> 	#else /* !CONFIG_HAVE_CLK */
> 	static inline int clk_set_min_rate(struct clk *clk, unsigned long rate)
> 	...
> 	-------------
> 
> It is implemented at clk.c.
> But it will be compiled via COMMON_CLK
> 
> 	--- Makefile ---
> 	...
> =>	obj-$(CONFIG_COMMON_CLK)	+= clk.o

You've got CONFIG_HAVE_CLK enabled, but CONFIG_COMMON_CLK disabled ?

hmm, the whole CONFIG_HAVE_CLK looks a bit weird to me. I wonder what's
the actual purpose of having this arch-specific.

IMHO, we should sort out whether there are some things that some arch
really *needs*, and what could be optional - then split that into
separate modules along this line.

It seems that clk_set_min_rate() belongs to CONFIG_COMMON_CLK, and
tegra30-devfreq.c needds to depend on CONFIG_COMMON_CLK.


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
