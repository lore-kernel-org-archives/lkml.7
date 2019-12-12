Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35772067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfLLO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:28:08 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:44120 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfLLO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:28:08 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E9C9D200A95;
        Thu, 12 Dec 2019 14:28:06 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id C62D320B6E; Thu, 12 Dec 2019 15:27:55 +0100 (CET)
Date:   Thu, 12 Dec 2019 15:27:55 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Simon Geis <simon.geis@fau.de>, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v2 00/10] PCMCIA/i82092: Fix style issues in i82092.c
Message-ID: <20191212142755.GC348041@light.dominikbrodowski.net>
References: <20191210114333.12239-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210114333.12239-1-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:43:24PM +0100, Simon Geis wrote:
> This patch series removes all style issues in i82092.c
> detected by checkpatch.pl.
> 
> Version 2 changes:
> - merge whitespace patches into a single patch
> - convert ?-operator to if statement (patch 7)
> - rewrite commit messages
> - add i82092 to subject
> - modify enter/leave macro

Thanks for your patches! Could you address the issues spotted by Greg,
please, and also two minor issues I have just sent you off-list, and
prepare a v3 of this patchset? Then, I'll merge your patches into
pcmcia-next and aim for upstreaming them for the next merge cycle (v5.6).

Thanks,
	Dominik
