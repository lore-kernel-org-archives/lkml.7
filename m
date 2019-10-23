Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78675CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5148A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah5HGVC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404187AbfJWSxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:53:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390527AbfJWSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571856811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ecQ98e61/2Ea388fkZplfUt1Z60f+MBx+DeZm7DbqNw=;
        b=Ah5HGVC626wlMRKhJyHH2Ncsbngly1vgYVNQnJTuQogBhVnqJf3kZw67CxZ4si+3tHdOzE
        ZKyjGMf8xVOouU4IA0jhNQ6wtictGOQr3Tygd8aaWSB8TNs1Mw0qeC0+fzhD9Y7yS4lZYv
        bl8rE2iv4ES0WaXDAyaiWFohM07QKr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7Lp0hEqHM_2VEfj9KFOBVA-1; Wed, 23 Oct 2019 14:53:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FEE01005500;
        Wed, 23 Oct 2019 18:53:26 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-79.ams2.redhat.com [10.36.116.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62CC360C57;
        Wed, 23 Oct 2019 18:53:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Gorbea Ainz <danielgorbea@hotmail.com>
Subject: [PATCH resend] Add touchscreen platform data for the Schneider SCT101CTM tablet
Date:   Wed, 23 Oct 2019 20:53:23 +0200
Message-Id: <20191023185323.13552-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7Lp0hEqHM_2VEfj9KFOBVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gorbea Ainz <danielgorbea@hotmail.com>

Add touchscreen platform data for the Schneider SCT101CTM tablet

Signed-off-by: Daniel Gorbea <danielgorbea@hotmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
hdegoede: Resend from my email address as vger.kernel.org does not like
Daniel's emails
---
 drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/=
touchscreen_dmi.c
index 8bfef880e216..ba494ace83d4 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -549,6 +549,24 @@ static const struct ts_dmi_data pov_mobii_wintab_p1006=
w_v10_data =3D {
 =09.properties=09=3D pov_mobii_wintab_p1006w_v10_props,
 };
=20
+static const struct property_entry schneider_sct101ctm_props[] =3D {
+=09PROPERTY_ENTRY_U32("touchscreen-size-x", 1715),
+=09PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+=09PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+=09PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+=09PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+=09PROPERTY_ENTRY_STRING("firmware-name",
+=09=09=09      "gsl1680-schneider-sct101ctm.fw"),
+=09PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+=09PROPERTY_ENTRY_BOOL("silead,home-button"),
+=09{ }
+};
+
+static const struct ts_dmi_data schneider_sct101ctm_data =3D {
+=09.acpi_name=09=3D "MSSL1680:00",
+=09.properties=09=3D schneider_sct101ctm_props,
+};
+
 static const struct property_entry teclast_x3_plus_props[] =3D {
 =09PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 =09PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -968,6 +986,14 @@ const struct dmi_system_id touchscreen_dmi_table[] =3D=
 {
 =09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
 =09=09},
 =09},
+=09{
+=09=09/* Schneider SCT101CTM */
+=09=09.driver_data =3D (void *)&schneider_sct101ctm_data,
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "SCT101CTM"),
+=09=09},
+=09},
 =09{
 =09=09/* Teclast X3 Plus */
 =09=09.driver_data =3D (void *)&teclast_x3_plus_data,
--=20
2.23.0

