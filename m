Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491F320857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfDHQnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:43:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:38405 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbfDHQnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:43:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 09:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="159288432"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2019 09:43:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hDXMg-0008Mp-Hb; Tue, 09 Apr 2019 00:43:22 +0800
Date:   Tue, 9 Apr 2019 00:42:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     kbuild-all@01.org, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH gfs2] gfs2: gfs2_buf_lops can be static
Message-ID: <20190408164240.GA95319@lkp-sb05>
References: <201904090050.0WbeTSpF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904090050.0WbeTSpF%lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 159238adb2ac ("gfs2: Remove unnecessary extern declarations")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 lops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 2fd6185..6c1ec6c 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -870,7 +870,7 @@ static void databuf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 }
 
 
-const struct gfs2_log_operations gfs2_buf_lops = {
+static const struct gfs2_log_operations gfs2_buf_lops = {
 	.lo_before_commit = buf_lo_before_commit,
 	.lo_after_commit = buf_lo_after_commit,
 	.lo_before_scan = buf_lo_before_scan,
@@ -879,7 +879,7 @@ const struct gfs2_log_operations gfs2_buf_lops = {
 	.lo_name = "buf",
 };
 
-const struct gfs2_log_operations gfs2_revoke_lops = {
+static const struct gfs2_log_operations gfs2_revoke_lops = {
 	.lo_before_commit = revoke_lo_before_commit,
 	.lo_after_commit = revoke_lo_after_commit,
 	.lo_before_scan = revoke_lo_before_scan,
@@ -888,7 +888,7 @@ const struct gfs2_log_operations gfs2_revoke_lops = {
 	.lo_name = "revoke",
 };
 
-const struct gfs2_log_operations gfs2_databuf_lops = {
+static const struct gfs2_log_operations gfs2_databuf_lops = {
 	.lo_before_commit = databuf_lo_before_commit,
 	.lo_after_commit = databuf_lo_after_commit,
 	.lo_scan_elements = databuf_lo_scan_elements,
