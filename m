Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0174C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D9720659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfFYHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:55:28 -0400
Received: from foss.arm.com ([217.140.110.172]:34576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFYHz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 420962B;
        Tue, 25 Jun 2019 00:55:27 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885DE3F246;
        Tue, 25 Jun 2019 00:55:24 -0700 (PDT)
Date:   Tue, 25 Jun 2019 08:55:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     will.deacon@arm.com, ard.biesheuvel@linaro.org, broonie@kernel.org,
        mark.rutland@arm.com, keescook@google.com, samitolvanen@google.com,
        jeffv@google.com, shawnguo@kernel.org,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: enable CONFIG_RANDOMIZE_BASE
Message-ID: <20190625075521.GA1784@iMac.local>
References: <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
 <20190624175852.46560-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624175852.46560-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:58:50AM -0700, Nick Desaulniers wrote:
> For testing coverage and improved defense in depth, enable KASLR by
> default.
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks. I'll queue this for 5.3.

-- 
Catalin
