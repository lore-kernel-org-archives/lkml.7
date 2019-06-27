Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17673C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFDC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF0AUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:20:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:65310 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfF0AUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:20:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 17:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="156052377"
Received: from mwsinger-mobl3.ger.corp.intel.com ([10.252.48.211])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 17:20:29 -0700
Message-ID: <b6828d53c84e6aa617e749882420a2b48ed77eec.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: tpm: add the TPM I2C PTP device
 tree binding documentation
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Oshri Alkoby <oshrialkoby85@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        tomer.maimon@nuvoton.com
Date:   Thu, 27 Jun 2019 03:20:41 +0300
In-Reply-To: <20190625223503.367710-2-oshrialkoby85@gmail.com>
References: <20190625223503.367710-1-oshrialkoby85@gmail.com>
         <20190625223503.367710-2-oshrialkoby85@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 01:35 +0300, Oshri Alkoby wrote:
> Signed-off-by: Oshri Alkoby <oshrialkoby85@gmail.com>

Long description missing.

/Jarkko

