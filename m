Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57459C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0F420733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKOPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:09:40 -0500
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:45530 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727406AbfKOPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:09:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7F1888383F91;
        Fri, 15 Nov 2019 15:09:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: death47_53dfe8b37a120
X-Filterd-Recvd-Size: 1331
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Nov 2019 15:09:36 +0000 (UTC)
Message-ID: <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
From:   Joe Perches <joe@perches.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 15 Nov 2019 07:09:17 -0800
In-Reply-To: <20191115150202.15208-1-erosca@de.adit-jv.com>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:
> Oftentimes [1], the contributor would like to honor or give credits [2]
> to somebody's original ideas in the submission/reviewing process. While
> "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> employed for this purpose, they are not ideal.

You need to get the use of this accepted into Documentation/process
before adding it to checkpatch


