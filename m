Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD72216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfE1Quz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:50:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfE1Quy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:50:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB43CA78;
        Tue, 28 May 2019 09:50:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D794C3F59C;
        Tue, 28 May 2019 09:50:50 -0700 (PDT)
Date:   Tue, 28 May 2019 17:50:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] lib/test_kasan: Add bitops tests
Message-ID: <20190528165048.GD28492@lakrids.cambridge.arm.com>
References: <20190528163258.260144-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528163258.260144-1-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 28, 2019 at 06:32:56PM +0200, Marco Elver wrote:
> +static noinline void __init kasan_bitops(void)
> +{
> +	long bits = 0;
> +	const long bit = sizeof(bits) * 8;

You can use BITS_PER_LONG here.

Thanks,
Mark.
