Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC1ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88EE206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfJNJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730667AbfJNJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:36:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5221DBD2E;
        Mon, 14 Oct 2019 09:36:21 +0000 (UTC)
Date:   Mon, 14 Oct 2019 11:36:36 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linux I2C <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/4] Instantiate SPD EEPROMs at boot on x86
Message-ID: <20191014113636.57b5ce89@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my work to let decode-dimms work out of the box on most x86
desktop and laptop systems.

[PATCH 1/4] firmware: dmi: Remember the memory type
[PATCH 2/4] firmware: dmi: Add dmi_memdev_handle
[PATCH 3/4] i2c: smbus: Add a way to instantiate SPD EEPROMs automatically
[PATCH 4/4] i2c: i801: Instantiate SPD EEPROMs automatically

-- 
Jean Delvare
SUSE L3 Support
