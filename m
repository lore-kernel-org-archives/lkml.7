Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D6C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A6C21900
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139174;
	bh=9wuw0+rjy7zF/MSnnIXbwfb1FaWshWKZUmWCmLJgIeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h2tCTjKIvib6SONSdBENxSEy07BxOJFvmmoxmh2uwgZ2phmk+mfU8vXh+K7/cF4HB
	 LfStRkpbvQgSHaqZie7cp8u8G0jrQUUvz3QrCOKzdwFKf2JnkIvMUFfrfD0ijx68nn
	 +A/AVmYXQaxyZZdAZhf/MoAHniqf1DGC7FiHPsRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfDARTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730737AbfDARTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39F321852;
        Mon,  1 Apr 2019 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139169;
        bh=9wuw0+rjy7zF/MSnnIXbwfb1FaWshWKZUmWCmLJgIeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUGkC0yIVZna3sCYafDIquIPy6ohtNDQEx2UlmcMrF7icdpWU5+/VeydzyA7BYFe7
         6L82PP5c4M1kOinPUJQVbMzutEzLfKKvyeuGc1t2jP8+sE5FcWvYiKAKkmsHSvQavB
         Rhbpd29JbeKvC5pUg909AofP4dYHOFHns+jcSBSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 134/134] platform: x86: intel_cht_int33fe: Remove the old connections for the muxes
Date:   Mon,  1 Apr 2019 19:02:50 +0200
Message-Id: <20190401170056.674658826@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 148b0aa78e4e1077e38f928124bbc9c2d2d24006 upstream.

USB Type-C class driver now expects the muxes to be always
assigned to the ports and not controllers, so the
connections for the mux and fusb302 can be removed.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_cht_int33fe.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,7 +34,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[8];
+	struct device_connection connections[5];
 };
 
 /*
@@ -174,29 +174,19 @@ static int cht_int33fe_probe(struct i2c_
 			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
 	}
 
-	data->connections[0].endpoint[0] = "i2c-fusb302";
+	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532";
 	data->connections[0].id = "typec-switch";
-	data->connections[1].endpoint[0] = "i2c-fusb302";
+	data->connections[1].endpoint[0] = "port0";
 	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
 	data->connections[1].id = "typec-mux";
-	data->connections[2].endpoint[0] = "i2c-fusb302";
+	data->connections[2].endpoint[0] = "port0";
 	data->connections[2].endpoint[1] = "i2c-pi3usb30532";
 	data->connections[2].id = "idff01m01";
 	data->connections[3].endpoint[0] = "i2c-fusb302";
 	data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
 	data->connections[3].id = "usb-role-switch";
 
-	data->connections[4].endpoint[0] = "port0";
-	data->connections[4].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[4].id = "typec-switch";
-	data->connections[5].endpoint[0] = "port0";
-	data->connections[5].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[5].id = "typec-mux";
-	data->connections[6].endpoint[0] = "port0";
-	data->connections[6].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[6].id = "idff01m01";
-
 	device_connections_add(data->connections);
 
 	memset(&board_info, 0, sizeof(board_info));


