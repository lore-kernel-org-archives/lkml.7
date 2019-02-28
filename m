Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D6C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551C420842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfB1GcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:32:00 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:57815 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1GcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:32:00 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DC724100D940C;
        Thu, 28 Feb 2019 07:31:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 81416D6B92; Thu, 28 Feb 2019 07:31:57 +0100 (CET)
Date:   Thu, 28 Feb 2019 07:31:57 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, okaya@kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Young <youngcdev@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: portdrv: Report degraded links via link
 bandwidth notification
Message-ID: <20190228063157.rl2lywgian2ij5m4@wunner.de>
References: <20190227205840.26898-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227205840.26898-1-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 02:58:17PM -0600, Alexandru Gagniuc wrote:
> A warning is generated when a PCIe device is probed with a degraded
> link, but there was no similar mechanism to warn when the link becomes
> degraded after probing. The Link Bandwidth Notification provides this
> mechanism.
> 
> Use the link bandwidth notification interrupt to detect bandwidth
> changes, and rescan the bandwidth, looking for the weakest point. This
> is the same logic used in probe().
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
