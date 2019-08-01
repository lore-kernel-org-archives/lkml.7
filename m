Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD8C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DE4214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564667698;
	bh=b6VWoGqdheqRkM9OnmHqVVLtc9wh2RvzqyHz1w64wq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dsz5z1LzcHaEmFGZ2UkFceTMYW8pTR/nvEAWbyoGNgRjsEkhYyPk3i3wrLsV/dzyn
	 31phEDzuQvTxJnFG4H+R17P2SDxwxkiHZ4R92DMBMzgpLPM9mtf7w9x/JX6zbaiMpZ
	 Hs0GzXIDiW0cvD84l4fOHViPXdLV8dYNKuPh3LII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfHANy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfHANy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:54:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED99520838;
        Thu,  1 Aug 2019 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564667696;
        bh=b6VWoGqdheqRkM9OnmHqVVLtc9wh2RvzqyHz1w64wq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItM6GyEuTDTexWouEuvuE6yqgoBCQNWyua7TBMBO6PF2GzVp/QJSJqbhLf1LMJBgf
         UApupRrrFtyoh4vLBmX04+Rg9Cz+IQr++Jhj/Comxf3sgZ+T4sACWMmzerV3ZeGa3t
         6N3lhwhcqAJ1l9Q2q8Ee4LATS0aeIj69ZpnOhpDk=
Date:   Thu, 1 Aug 2019 15:54:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, lkp@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: Revert incorrect conversion to use generic
 helper
Message-ID: <20190801135451.GA26585@kroah.com>
References: <20190801061042.GA1132@kroah.com>
 <20190801102026.27312-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801102026.27312-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:20:24AM +0100, Suzuki K Poulose wrote:
> The patch "drivers: Introduce device lookup variants by ACPI_COMPANION device"
> converted an incorrect instance in i2c driver to a new helper. Revert this
> change.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Fixes: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")

I'll go add this...
