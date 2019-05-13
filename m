Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AA920879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfEMGjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 02:39:33 -0400
Received: from verein.lst.de ([213.95.11.211]:37244 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfEMGjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 02:39:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DF69368AA6; Mon, 13 May 2019 08:39:12 +0200 (CEST)
Date:   Mon, 13 May 2019 08:39:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepak Mishra <linux.dkm@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] scripts/spdxcheck.py - fix list of directories to check
Message-ID: <20190513063912.GB18327@lst.de>
References: <2008.1557646828@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2008.1557646828@turing-police>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank, this looks good but Sven Eckelmann sent the same changes a
little earlier.
