Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE749206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412092;
	bh=R3t/jsqtF3rBrrXgTyAr1qCpkpt8x1DmU8CVg731CN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDYpoRIXLO1EdyiQz8K9lHnB9KmIElVzeU7iMjffwKv0FD4dgvavULihhF6iQROtD
	 eyNMCyRLQDIZwtk6rcBklX9hXjCaE6eg5qxafvYPoMrwvT+6+gOuVz9/3yMlI9fgnI
	 i6nKrVpd1ptNa9L+qN4Fth9O8cGDWU4PRYtprbNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfCLReu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfCLRQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:56 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969452171F;
        Tue, 12 Mar 2019 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411015;
        bh=R3t/jsqtF3rBrrXgTyAr1qCpkpt8x1DmU8CVg731CN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKIPwLW+IRPtZ5YxIrj+0ylrTV+dF2esed9SPxQBe7kzj6gtlT9sZVpiEx3K9Vg8B
         vWxY5/pniCwZQ9BukcsQfYAmuG5GUcQQMOamTxBFpx8t5a4G4t1VKeYKlmfG6kstT7
         YlkhzuLnVpm4GjHXRZCaIV5lXDEhBKj1IdGGxKZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Batts <vbatts@hashbangbash.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 121/135] Input: elan_i2c - add id for touchpad found in Lenovo s21e-20
Date:   Tue, 12 Mar 2019 10:09:28 -0700
Message-Id: <20190312170352.325912910@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Batts <vbatts@hashbangbash.com>

commit e154ab69321ce2c54f19863d75c77b4e2dc9d365 upstream.

Lenovo s21e-20 uses ELAN0601 in its ACPI tables for the Elan touchpad.

Signed-off-by: Vincent Batts <vbatts@hashbangbash.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1252,6 +1252,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0601", 0 },
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },
 	{ "ELAN0608", 0 },


