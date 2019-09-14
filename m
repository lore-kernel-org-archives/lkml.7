Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF4AC49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A3D2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfINHzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 03:55:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:35666 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfINHzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:55:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 29F57378;
        Sat, 14 Sep 2019 07:55:04 +0000 (UTC)
Date:   Sat, 14 Sep 2019 01:55:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Will Deacon <will@kernel.org>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] doc:lock: remove reference to clever use of
 read-write lock
Message-ID: <20190914015500.771466c8@lwn.net>
In-Reply-To: <20190912133226.oeo3eecvzfr52yv3@willie-the-truck>
References: <20190908062901.4218-1-federico.vaga@vaga.pv.it>
        <20190912133226.oeo3eecvzfr52yv3@willie-the-truck>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 14:32:27 +0100
Will Deacon <will@kernel.org> wrote:

> > So there is no reason to teach cleaver things that people should not do.  
> 
> cleaver => clever

I dunno...personally I'm also opposed to teaching people tricks with
cleavers too, at least in the kernel-development context.  Our flame wars
are bad enough as it is...:)

Applied with the typo tweaks, thanks.

jon
