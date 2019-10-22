Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E336CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E920882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvNvMH8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfJVCka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:40:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387442AbfJVCk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=db9/FSAmKT0MnuPKHIiAKkFAQGlG8AAFjVTq9TTRJZQ=;
        b=VvNvMH8RtJhfXRhgbaXoJCo8BodBsXsu2x7/raJChoPEmwnXri0U3aM7CXYNTmAanD1yMM
        RnWTW1aaRe/3BZKm0h8sTJrwAGHHiH30zTwgXjygV/x/zKr4FaDlO68uu0hy703cGonoyP
        KH8ayEV9mL74ALUwoXM+cJrwXXH3e+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-4KKH-D0uMUWkmlss76nB1A-1; Mon, 21 Oct 2019 22:40:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 622141005500;
        Tue, 22 Oct 2019 02:40:22 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79BAB60161;
        Tue, 22 Oct 2019 02:40:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/14] drm/dp_mst: Lessen indenting in drm_dp_mst_topology_mgr_resume()
Date:   Mon, 21 Oct 2019 22:36:03 -0400
Message-Id: <20191022023641.8026-9-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4KKH-D0uMUWkmlss76nB1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does what it says on the tin.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 59 +++++++++++++--------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index c8e218b902ae..d486d15aa002 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3212,45 +3212,44 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
  */
 int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
 {
-=09int ret =3D 0;
+=09int ret;
+=09u8 guid[16];
=20
 =09mutex_lock(&mgr->lock);
+=09if (!mgr->mst_primary)
+=09=09goto out_fail;
=20
-=09if (mgr->mst_primary) {
-=09=09int sret;
-=09=09u8 guid[16];
+=09ret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
+=09=09=09       DP_RECEIVER_CAP_SIZE);
+=09if (ret !=3D DP_RECEIVER_CAP_SIZE) {
+=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
+=09=09goto out_fail;
+=09}
=20
-=09=09sret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEI=
VER_CAP_SIZE);
-=09=09if (sret !=3D DP_RECEIVER_CAP_SIZE) {
-=09=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
-=09=09=09ret =3D -1;
-=09=09=09goto out_unlock;
-=09=09}
+=09ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
+=09=09=09=09 DP_MST_EN |
+=09=09=09=09 DP_UP_REQ_EN |
+=09=09=09=09 DP_UPSTREAM_IS_SRC);
+=09if (ret < 0) {
+=09=09DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
+=09=09goto out_fail;
+=09}
=20
-=09=09ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-=09=09=09=09=09 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
-=09=09if (ret < 0) {
-=09=09=09DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
-=09=09=09ret =3D -1;
-=09=09=09goto out_unlock;
-=09=09}
+=09/* Some hubs forget their guids after they resume */
+=09ret =3D drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
+=09if (ret !=3D 16) {
+=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
+=09=09goto out_fail;
+=09}
+=09drm_dp_check_mstb_guid(mgr->mst_primary, guid);
=20
-=09=09/* Some hubs forget their guids after they resume */
-=09=09sret =3D drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
-=09=09if (sret !=3D 16) {
-=09=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
-=09=09=09ret =3D -1;
-=09=09=09goto out_unlock;
-=09=09}
-=09=09drm_dp_check_mstb_guid(mgr->mst_primary, guid);
+=09mutex_unlock(&mgr->lock);
=20
-=09=09ret =3D 0;
-=09} else
-=09=09ret =3D -1;
+=09return 0;
=20
-out_unlock:
+out_fail:
 =09mutex_unlock(&mgr->lock);
-=09return ret;
+=09return -1;
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_resume);
=20
--=20
2.21.0

