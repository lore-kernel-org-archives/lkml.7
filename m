Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A1C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F31F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgAGVK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:10:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37514 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729566AbgAGVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:10:54 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007LAkXa027192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:10:46 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E4F464207DF; Tue,  7 Jan 2020 16:10:45 -0500 (EST)
Date:   Tue, 7 Jan 2020 16:10:45 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] random: remove unnecessary unlikely()
Message-ID: <20200107211045.GO3619@mit.edu>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607182517.28266-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:25:13PM -0400, Yangtao Li wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied, thanks.

					- Ted
