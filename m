Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A2C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B0E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfEMGjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 02:39:07 -0400
Received: from verein.lst.de ([213.95.11.211]:37239 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfEMGjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 02:39:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ED2B468AA6; Mon, 13 May 2019 08:38:45 +0200 (CEST)
Date:   Mon, 13 May 2019 08:38:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scripts/spdxcheck.py: Fix path to deprecated licenses
Message-ID: <20190513063845.GA18327@lst.de>
References: <20190511201917.20828-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511201917.20828-1-sven@narfation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both patches:

Reviewed-by: Christoph Hellwig <hch@lst.de>
