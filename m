Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF31C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93ED2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLDBWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLDBWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:22:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19DE1206DF;
        Wed,  4 Dec 2019 01:22:01 +0000 (UTC)
Date:   Tue, 3 Dec 2019 20:22:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        fabien.lahoudere@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] x86_64_defconfig: Normalize x86_64 defconfig
Message-ID: <20191203202200.5565c451@gandalf.local.home>
In-Reply-To: <CAJKOXPfzYSJdVg_j7MPP14WOve0cJpF+NV2FWWhjGbUEwVWavw@mail.gmail.com>
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
        <20191202211844.19629-2-enric.balletbo@collabora.com>
        <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
        <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com>
        <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
        <CAMuHMdXdWASPa3yr04N5w9jTt3=jC_H20yVpcG1J1_Sx0PRtgA@mail.gmail.com>
        <CAJKOXPfzYSJdVg_j7MPP14WOve0cJpF+NV2FWWhjGbUEwVWavw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 09:15:12 +0800
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Instead of keeping this known good config somewhere outside it should
> be just equal to defconfig. There is no point to trim it with
> savedefconfig and then later experience missing options (because some
> option was a dependency but now is not). Instead, all visible options
> (possible to select) should be explicitly defined by defconfig to
> avoid what happened with DEBUG_FS.

I totally agree.

-- Steve
