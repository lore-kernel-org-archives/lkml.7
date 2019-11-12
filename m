Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC2C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A94214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKLN3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:29:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfKLN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:29:46 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACDO2tT076505;
        Tue, 12 Nov 2019 08:29:44 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7qdab4wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 08:29:42 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACDPK9s012899;
        Tue, 12 Nov 2019 13:29:00 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 2w5n35xwmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 13:28:59 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACDSwGT30277928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 13:28:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B34AD2805E;
        Tue, 12 Nov 2019 13:28:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 117AF2805A;
        Tue, 12 Nov 2019 13:28:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 13:28:57 +0000 (GMT)
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
Date:   Tue, 12 Nov 2019 08:28:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112033637.kxotlhm6mtr5irvd@cantor>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=682 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 10:36 PM, Jerry Snitselaar wrote:
> Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ 
> before probing for interrupts").
> Doesn't tpm_tis_send set this flag, and setting it here in 
> tpm_tis_core_init short circuits what
> tpm_tis_send was doing before? There is a bug report of an interrupt 
> storm from a tpm on a t490s laptop
> with the Fedora 31 kernel (5.3), and I'm wondering if this change 
> could cause that. Before they got
> the warning about interrupts not working, and using polling instead.
>
I set this flag for the TIS because it wasn't set anywhere else. 
tpm_tis_send() wouldn't set the flag but go via the path:

if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)

         return tpm_tis_send_main(chip, buf, len);

the only other line for the TIS to set the IRQ flag was in the same 
function further below, though that wouldn't be reached due to the above:

[...]

priv->irq = irq;

chip->flags |= TPM_CHIP_FLAG_IRQ;


    Stefan


