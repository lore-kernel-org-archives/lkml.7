Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6A121D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ybmwf7xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfKLORR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:17:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbfKLORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573568236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a7B/szubeZq42YZldG2uwMh1+KLmbg60Npq16IJbOZM=;
        b=Ybmwf7xHgJtba8x6YzRYUNYCjUCm3hUus3oggO5M4uNPP7wagQeZ7Q+UaIYhTvPrRpuGoU
        gxCaTDLkUJj+141PWW91FNQLA3q3uzyIqOwMEBetl7dof6X8tq5m3QY+JaiTnhod8K3TuJ
        mWdMDGdN+LYfOPOMa80rbyFx+QFrOgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-cDLH9rFnPaSiVN6nncmdAg-1; Tue, 12 Nov 2019 09:17:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8D7477;
        Tue, 12 Nov 2019 14:17:14 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A736299BD;
        Tue, 12 Nov 2019 14:17:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        youling257 <youling257@gmail.com>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the ezpad 6 m4 tablet
Date:   Tue, 12 Nov 2019 15:17:11 +0100
Message-Id: <20191112141711.26220-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cDLH9rFnPaSiVN6nncmdAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Jumper EZpad 6 m4 tablet.

Reported-and-tested-by: youling257 <youling257@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/=
touchscreen_dmi.c
index ba494ace83d4..4a09b479cda5 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -343,6 +343,22 @@ static const struct ts_dmi_data jumper_ezpad_6_pro_b_d=
ata =3D {
 =09.properties     =3D jumper_ezpad_6_pro_b_props,
 };
=20
+static const struct property_entry jumper_ezpad_6_m4_props[] =3D {
+=09PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
+=09PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
+=09PROPERTY_ENTRY_U32("touchscreen-size-x", 1950),
+=09PROPERTY_ENTRY_U32("touchscreen-size-y", 1525),
+=09PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-jumper-ezpad-6-m4.fw"),
+=09PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+=09PROPERTY_ENTRY_BOOL("silead,home-button"),
+=09{ }
+};
+
+static const struct ts_dmi_data jumper_ezpad_6_m4_data =3D {
+=09.acpi_name=09=3D "MSSL1680:00",
+=09.properties=09=3D jumper_ezpad_6_m4_props,
+};
+
 static const struct property_entry jumper_ezpad_mini3_props[] =3D {
 =09PROPERTY_ENTRY_U32("touchscreen-min-x", 23),
 =09PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
@@ -866,6 +882,16 @@ const struct dmi_system_id touchscreen_dmi_table[] =3D=
 {
 =09=09=09DMI_MATCH(DMI_BIOS_DATE, "04/24/2018"),
 =09=09},
 =09},
+=09{
+=09=09/* Jumper EZpad 6 m4 */
+=09=09.driver_data =3D (void *)&jumper_ezpad_6_m4_data,
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "jumper"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "EZpad"),
+=09=09=09/* Jumper8.S106x.A00C.1066 with the version dropped */
+=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "Jumper8.S106x"),
+=09=09},
+=09},
 =09{
 =09=09/* Jumper EZpad mini3 */
 =09=09.driver_data =3D (void *)&jumper_ezpad_mini3_data,
--=20
2.23.0

