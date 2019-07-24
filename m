Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA25C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7184D21743
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGXKfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:35:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGXKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:35:52 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqEcd-0004JD-FR; Wed, 24 Jul 2019 12:35:47 +0200
Date:   Wed, 24 Jul 2019 12:35:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     mingo@redhat.com, bp@alien8.de, peterz@infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, stable@vger.kernel.org,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v3 2/2] x86/purgatory: use CFLAGS_REMOVE rather than
 reset KBUILD_CFLAGS
In-Reply-To: <20190723212418.36379-2-ndesaulniers@google.com>
Message-ID: <alpine.DEB.2.21.1907241233240.1972@nanos.tec.linutronix.de>
References: <20190723212418.36379-1-ndesaulniers@google.com> <20190723212418.36379-2-ndesaulniers@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019, Nick Desaulniers wrote:
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_sha256.o += $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_purgatory.o += $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_string.o += $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_kexec-purgatory.o += $(CC_FLAGS_FTRACE)

Nit. Can you please make that tabular?

CFLAGS_REMOVE_sha256.o		+= $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_purgatory.o	+= $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_string.o		+= $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_kexec-purgatory.o	+= $(CC_FLAGS_FTRACE)

The above confused my pattern recognition engine :)

Thanks,

	tglx
