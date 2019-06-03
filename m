Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E45BC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5527FDA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfFCJYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfFCJYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096317"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 0/7] mei: docs: move documentation under driver-api
Date:   Mon,  3 Jun 2019 12:13:59 +0300
Message-Id: <20190603091406.28915-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mei documentation under driver-api, convert the docs to rst,
fix the outdated information, update broken links, and add new docs.


Tomas Winkler (7):
  mei: docs: move documentation under driver-api
  mei: docs: move iamt docs to a iamt.rst file
  mei: docs: update mei documentation
  mei: docs: update mei client bus documentation.
  mei: docs: add a short description for nfc behind mei
  mei: docs: add hdcp documentation
  mei: docs: fix broken links in iamt documentation.

 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/mei/hdcp.rst         |  32 +++
 Documentation/driver-api/mei/iamt.rst         | 101 +++++++
 Documentation/driver-api/mei/index.rst        |  23 ++
 .../driver-api/mei/mei-client-bus.rst         | 168 +++++++++++
 Documentation/driver-api/mei/mei.rst          | 176 ++++++++++++
 Documentation/driver-api/mei/nfc.rst          |  28 ++
 .../misc-devices/mei/mei-client-bus.txt       | 141 ----------
 Documentation/misc-devices/mei/mei.txt        | 266 ------------------
 MAINTAINERS                                   |   2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c              |  11 +-
 11 files changed, 534 insertions(+), 415 deletions(-)
 create mode 100644 Documentation/driver-api/mei/hdcp.rst
 create mode 100644 Documentation/driver-api/mei/iamt.rst
 create mode 100644 Documentation/driver-api/mei/index.rst
 create mode 100644 Documentation/driver-api/mei/mei-client-bus.rst
 create mode 100644 Documentation/driver-api/mei/mei.rst
 create mode 100644 Documentation/driver-api/mei/nfc.rst
 delete mode 100644 Documentation/misc-devices/mei/mei-client-bus.txt
 delete mode 100644 Documentation/misc-devices/mei/mei.txt

-- 
2.20.1

