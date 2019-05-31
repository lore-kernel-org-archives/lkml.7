Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720DAC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4230B26928
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559307820;
	bh=EAcHXloLVvWOmeaCQKGt2kykF6vQUgK3h5YLYFZKb5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rGhKhUsr6tz58AwXuY7CB39Is1pD5N7K1vim4acxNOh5F3HSk/MNXG0zgd+fyCeIH
	 sPehc4YRjJJCWAKGhJhZpn9YxQOsmh6SccF/QCo0esNQUN2R2HJ9dh/3HcFWQd3hgO
	 Ie8N8VPFFrRrRdEMfWsjpxCFjWRzOaViNodqsIYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEaNDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaNDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:03:39 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AFA226928;
        Fri, 31 May 2019 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559307818;
        bh=EAcHXloLVvWOmeaCQKGt2kykF6vQUgK3h5YLYFZKb5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0xA4neoblMrz9g0w77d8Ik0pV5W3wOMiLGHIt48Qv6JWGepPT7uMm7mCu3c0A6O0M
         u6TYIV3M0BPYWe/tU+/R5Y8z+iayyr2RshD+zlN9jkJmqa5h4/BKw9+0FfYpsiwhy3
         CC763w4f6Em3BN69cmomHPMD/zy8RSSze4aDNass=
Date:   Fri, 31 May 2019 08:03:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v3 1/5] PCI/ACPI: Add _OSC based negotiation support for
 DPC
Message-ID: <20190531130336.GO28250@google.com>
References: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <1d7b8966972edcad8ac9f219e9d83b47beb85f6f.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7b8966972edcad8ac9f219e9d83b47beb85f6f.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 03:18:13PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI Firmware Specification, r3.2 ECN
> (https://members.pcisig.com/wg/PCI-SIG/document/12614), OS can use
> bit 7 of _OSC Control Field to negotiate control over Downstream Port
> Containment (DPC) configuration of PCIe port.

I think this citation should reference the "Downstream Port
Containment Related Enhancements ECN", i.e., it should include the
title of the ECN.  I first thought you were citing the PCI Firmware
Spec, r3.2, but of course it's not in there.

Bjorn
