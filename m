Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18AB2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139164;
	bh=sBY9z37+jY0bPHI88jjPSabwlrYysRq2AhoSZJ2KNYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q1LOyAZRI0R3i/FUNav04TCcugGpSV9fTW8tTn4RZJEIAOL1VZqyRU1Ln2yKz0+5h
	 gzH7D8NPxl79uV9y939Qhh3ko+9cd6sf0SvwrsKwaVHtYsImz6DULC3gHDn1BBX5RJ
	 OAY36IuZ6RMiZPU6yv3M1amFkQRZNMN1zPINsJrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfDARTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731302AbfDARTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7774E21852;
        Mon,  1 Apr 2019 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139159;
        bh=sBY9z37+jY0bPHI88jjPSabwlrYysRq2AhoSZJ2KNYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szp+pDF0D0E3z1rUnMIbc94OPGk0qoxbHvTELTSwdtaZcX4qp1kBS79BHD3oN9079
         Px4NyL4XBpPEz2kp8n/LnA/74Cl1eX094TVGko0asJyNd/HWNyTkRFZHkxhiIVMdVW
         H3OR8Io59/HNQiZ9sfLzKzj7oQJJ/aFcw7XdXeA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 131/134] platform: x86: intel_cht_int33fe: Add connection for the DP alt mode
Date:   Mon,  1 Apr 2019 19:02:47 +0200
Message-Id: <20190401170056.448072463@linuxfoundation.org>
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

commit 78d2b54b134ea6059e2b1554ad53fab2300a4cc6 upstream.

Adding a connection for the DisplayPort alternate mode.
PI3USB30532 is used for muxing the port to DisplayPort on
CHT platforms. The connection allows the alternate mode
device to get handle to the mux, and therefore make it
possible to use the USB Type-C connector as DisplayPort.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_cht_int33fe.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,7 +34,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[4];
+	struct device_connection connections[5];
 };
 
 /*
@@ -181,8 +181,11 @@ static int cht_int33fe_probe(struct i2c_
 	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
 	data->connections[1].id = "typec-mux";
 	data->connections[2].endpoint[0] = "i2c-fusb302";
-	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
-	data->connections[2].id = "usb-role-switch";
+	data->connections[2].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[2].id = "idff01m01";
+	data->connections[3].endpoint[0] = "i2c-fusb302";
+	data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
+	data->connections[3].id = "usb-role-switch";
 
 	device_connections_add(data->connections);
 


