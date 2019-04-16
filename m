Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8069EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCFF2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfDPFBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:01:06 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59798 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfDPFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:01:06 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 906E7200941;
        Tue, 16 Apr 2019 05:01:04 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 581062033D; Tue, 16 Apr 2019 06:58:01 +0200 (CEST)
Date:   Tue, 16 Apr 2019 06:58:01 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 24/57] docs: pcmcia: convert it to ReST format
Message-ID: <20190416045801.GA13259@light.dominikbrodowski.net>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
 <e3c4827b8f33af90e4628de6590c6e040a20779c.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c4827b8f33af90e4628de6590c6e040a20779c.1555382110.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:55:49PM -0300, Mauro Carvalho Chehab wrote:
> Convert the pcmcia docs to ReST format. Most of the changes here
> are trivial, making Sphinx properly identify titles, lists and
> literal blocks.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
