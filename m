Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE1FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BC7206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgACKHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:07:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56511 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgACKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:07:05 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1inJrC-0004Gs-7K; Fri, 03 Jan 2020 11:07:02 +0100
Message-ID: <c44922a91cb0ee35231288f825d64182cae658f2.camel@pengutronix.de>
Subject: Re: [PATCH v6 2/2] reset: intel: Add system reset controller driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, martin.blumenstingl@googlemail.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Date:   Fri, 03 Jan 2020 11:07:01 +0100
In-Reply-To: <578307a64c72a72d87c77bd9b5e97143b914cbde.1578021776.git.eswara.kota@linux.intel.com>
References: <ab84cc2ada92e4512ff18b11d6f1f752e5821b67.1578021776.git.eswara.kota@linux.intel.com>
         <578307a64c72a72d87c77bd9b5e97143b914cbde.1578021776.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-03 at 18:00 +0800, Dilip Kota wrote:
> Add driver for the reset controller present on Intel
> Gateway SoCs for performing reset management of the
> devices present on the SoC. Driver also registers a
> reset handler to peform the entire device reset.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v6:
> 	Address review comments
> 	 Define structures xrx200_data and lgm_data as static const
> 	 Remove timer as parameter for intel_set_clr_bits()
> 	Correct the alignments during restart_nb structure field assignments

Thank you, both applied to reset/next.

regards
Philipp

