Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403FDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08096205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEHOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:52:50 -0400
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:53832 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727224AbfEHOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:52:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A3E7180A814F;
        Wed,  8 May 2019 14:52:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sand63_18313cd388c03
X-Filterd-Recvd-Size: 1786
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 14:52:46 +0000 (UTC)
Message-ID: <73a79b49d0183468a63876b170d1318d38c78d73.camel@perches.com>
Subject: Re: [PATCH 4/4] checkpatch: replace magic value for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:52:45 -0700
In-Reply-To: <20190508122721.7513-4-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
         <20190508122721.7513-4-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:27 +0200, Antonio Borneo wrote:
> The size of 8 characters used for both TAB and indentation is
> embedded as magic value allover the checkpatch script, and this
> makes the script less readable.
> 
> Replace the magic value 8 with the perl variable "$tabsize".
> From the context of the code it's clear if it is used for
> indentation or tabulation, so no need to use two separate
> variables.
> 
> As side benefit of this change, it makes easy to replace the TAB
> size when this script is used by other projects with different
> requirements in their coding style (e.g. OpenOCD [1] requires
> TAB size of 4 characters [2]).
> In these cases the script will be probably modified and adapted,
> so there is no need (at least for the moment) to expose this
> setting on the script's command line.

Disagree.  Probably getter to add a --tabsize=<foo> option now.


