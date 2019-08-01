Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF5DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB0B21726
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564666294;
	bh=TXVrjSx8YXeMl/a+rfUOaJEIS4U8QY+Mo9o734RkmLM=;
	h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=eyA2wdDGhMLQNHHk4GOxgdECgXfVEpvcowVZq7mTAfLcoDAFqDqPd1JZA2lq7+tNs
	 oSWws+BSs3nqdm9kQ8WAXmQUzi0hpMa5WxSrW/v1iwNoLkNY2qe+FMdEzbDkeOPdKy
	 YZvXvIsFSn1t6YVvss4reehIOnuJnNQN9FPDWQOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfHANbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbfHANbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:31:33 -0400
Received: from localhost (unknown [23.100.24.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF30206A3;
        Thu,  1 Aug 2019 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564666292;
        bh=TXVrjSx8YXeMl/a+rfUOaJEIS4U8QY+Mo9o734RkmLM=;
        h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
        b=uq9jMnG2F62W44Kgl4kzhjMcZVif2bP8BtU28YIcMoT/P0s9ZBXZVgo8PEVLcDkkG
         tXJ//kzswEEs56olnSrngSONmyETh6tIxGOOmadMYj+LRt2+R7xtLEy8PQfJITKauv
         sdKkD1jM0hUJ0USoAGMjbYSgWElo6lwcEyy24vg4=
Date:   Thu, 01 Aug 2019 13:31:31 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
To:     Vladis Dronov <vdronov@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH v5.3-rc2] Bluetooth: hci_uart: check for missing tty operations
In-Reply-To: <20190730093345.25573-1-marcel@holtmann.org>
References: <20190730093345.25573-1-marcel@holtmann.org>
Message-Id: <20190801133132.6BF30206A3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: .

The bot has tested the following trees: v5.2.4, v5.1.21, v4.19.62, v4.14.134, v4.9.186, v4.4.186.

v5.2.4: Build OK!
v5.1.21: Build OK!
v4.19.62: Build OK!
v4.14.134: Failed to apply! Possible dependencies:
    25a13e382de2 ("bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL")

v4.9.186: Failed to apply! Possible dependencies:
    25a13e382de2 ("bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL")

v4.4.186: Failed to apply! Possible dependencies:
    162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
    25a13e382de2 ("bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL")
    395174bb07c1 ("Bluetooth: hci_uart: Add Intel/AG6xx support")
    9e69130c4efc ("Bluetooth: hci_uart: Add Nokia Protocol identifier")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
