Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B16C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D892084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfDBOTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:19:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfDBOTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:19:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2440AE67;
        Tue,  2 Apr 2019 14:19:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B02DEDA824; Tue,  2 Apr 2019 16:20:16 +0200 (CEST)
Date:   Tue, 2 Apr 2019 16:20:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Rob Herring <robh@kernel.org>, Jiri Slaby <JSlaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: add SPDX identifiers to Kconfig and Makefiles
Message-ID: <20190402142016.GB29086@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Rob Herring <robh@kernel.org>, Jiri Slaby <JSlaby@suse.com>,
        linux-kernel@vger.kernel.org
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402140708.519-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 04:07:07PM +0200, Greg Kroah-Hartman wrote:
> There were a few Kconfig and Makefiles under drivers/tty/ that were
> missing a SPDX identifier.  Fix that up so that automated tools can
> properly classify all kernel source files.
> 
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

For

>  drivers/tty/ipwireless/Makefile      | 1 +

Acked-by: David Sterba <dsterba@suse.com>
