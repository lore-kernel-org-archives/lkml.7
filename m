Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A11EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF4A218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfCOP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:27:51 -0400
Received: from 8bytes.org ([81.169.241.247]:57916 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfCOP1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:27:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8600D329; Fri, 15 Mar 2019 16:27:49 +0100 (CET)
Date:   Fri, 15 Mar 2019 16:27:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH] iommu/amd: Fix a null pointer dereference for ACPI
 devices
Message-ID: <20190315152747.GB16974@8bytes.org>
References: <20190308041210.84518-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308041210.84518-1-chiu@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Fri, Mar 08, 2019 at 12:12:10PM +0800, Chris Chiu wrote:
> On ASUS laptop X512DK with the realtek USB card reader, the NULL
> pointer dereference happens while bringing up the rtsx_usb driver.

Thanks for your patch, but I applied

	https://lore.kernel.org/lkml/1552485204-11381-1-git-send-email-aaron.ma@canonical.com/

instead because it fixes the issue where the NULL-ptr dereference
happens. This also covers all future uses of the match_hid_uid()
function.

Thanks,

	Joerg
