Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F42CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C1A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="EyVFajeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbfJVQe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:34:26 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com ([77.238.179.187]:39120
        "EHLO sonic313-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389468AbfJVQe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1571762063; bh=A1vX4VWQPMbJ7Dk8UtwOVAMMg74z40Il0hGsPeYA4/s=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=EyVFajeUeZ+PE/ud3G7Xyqe3DHS4TmKrkNq3vlfn71bf3TCIRaYIDbgnjpptaQuNgim5Gf3m4LXp11h3hfXVshRId9+Ih++03WP0vLO8LC70RH+0Ros5gB6aYzK7rf6WMn4lPTudsHDN/eFpizbZrJx4jGWQ6MbVl89QnMVBONyYlSuvDPPY3wf3pBaj4Ei2SV2p2UKbeJrQhwJ/DiRhHsd5uqRRQnAogUOu4FPxQL78VyB8nbIULXy7z1MucoP4q+q9qDJHI2hKZU+uSGOOd5ccdPDP+dFR84UZjws8spAiNx6DaT2QirnMyg/ya22SywBUqVczHl9TWxrdJkdTgg==
X-YMail-OSG: oekYUEoVM1mD_cCU8AsDerKUQS8vRHCBQQ9Yvxm4alyR5jvdurJPxgGPX344cNx
 u9vcTRWnd.FrEJTKSTykoql.edZi.YxUHVu4c0jZHzLQ3Mj1T7Wj8RClQIUSpOmf35tgRD8GqAjd
 .EuwchCYfpG0i0NVbeHdtWlVkgo21_wvFKsbLI2kIjX049MlrlwrgHBOSmfwRQEwKuP1K3UfZmhj
 NDix1Fq4W_7YPVmH613AqU6LaRArbitEDIL03_ofuza6Pb5Tm.dZfmc18wOCjs3P1gR8TLE6wzoi
 0qeVQ_D6j2k12rlE7v2c6DgmJ7_d1MKF9_xDhX9rUb4W5FXGupVudhgPVc8.AydOTDxr2GCLJ9ym
 5FD61.HKg.jtGP_Xejq5gp3HhFzs89jFtMXzNUktw.IOKyOaezIZF7JSv_QobHUPj8p1.ehn7Bam
 INWxYRbhwWInjUMspMQ2jzk7ZCd7tGdPN_xwEdDZllU_imGsZXfwKM9vd84cQ8VjtnS2yvjIOHmy
 8Qm.KiUXL8KraT3VYILrE_KKArLQtDskc9KrKBH2GfklgCJtob8ISgvY3jLMgblSo9Xb6HcLA6tj
 ZRr8El32jciUTKYuhMmMTNiQAzzQdoUBf6soT8_qHwr0SrmOxDJN57yIC7ldnx5FpButky7CtYc2
 yqZnsYg58I7EzzZ5YEe8UXucr2uLpKBgZ88X.9NdAzn1vFU8o_6.uCGHlCktcG5XKV3SmtlfCLwr
 awt9QogzPPTdKJQsPz6ms64VRre4_F.Wr1m0GJifvnLlHmWRCZmBlWev9MxxRV36EzRnjmxLhEYq
 dek84Ck7CFUnlOsK__uSVm__jS.ad9eLn9tdX2VtCdL7usPZr2hJqO8K4lKUjMXSEDUAAxYf_z2z
 Xttk61dDiYz.GQX48nVBkEkFhU9UZqOYmsoGwc5nsjdSwkK7j5_G8AZ6P2s4sJQ_jevBCDQl5sHJ
 U6hfDKM7.5xK86pvxWTIUsc.qnCJuCNBnxWBlbGFEK.2xd4SzLcoIkJlrfMC1kWAH_LrET9ROKed
 Ou9jP1r5p4OA.y1X2B2.4DTAhD0u0J2MDLf3P38M.P1.sWl8pBNTx4GLi5sXaDFW13TlzMBQzVQX
 LTW8v133gxDpqLVPbMcOEbd2F2RuGbo0ZLeAcX4o0xQl6IF_vpIJQdnqly21qBfE.GqrFZr_bJhS
 OYBvsLfUnX0uz1kwSx6jmrjRAL679WoRpexYGSKjRSKxHbAzKQPlTv9Fka5JP14MoFzWfAP2v9hi
 5kIFxJEE_.AfQ9tbNZod3JukLAohBo0JiSKnGWtbv1Am7OD2dEUS4crpnwxqKuibjy5vYXBD6q0o
 9jRRgNfc30zt1PnUorfnQEQIcglJ5zMpPgFAt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Tue, 22 Oct 2019 16:34:23 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID af731488e5dabafbb7badc3449baeb13;
          Tue, 22 Oct 2019 16:34:22 +0000 (UTC)
Date:   Wed, 23 Oct 2019 00:34:15 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Pratik Shinde <pratikshinde320@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, gaoxiang25@huawei.com,
        yuchao0@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-v2] erofs: code for verifying superblock checksum of an
 erofs image.
Message-ID: <20191022163403.GA3201@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191022153956.16867-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022153956.16867-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

Some comments as below...

On Tue, Oct 22, 2019 at 09:09:56PM +0530, Pratik Shinde wrote:
> Patch for kernel side changes of checksum feature.Used kernel's
> crc32c library for calculating the checksum.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  fs/erofs/erofs_fs.h |  5 +++--
>  fs/erofs/internal.h |  3 ++-
>  fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b1ee565..4d8097a 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -17,6 +17,7 @@
>   */
>  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_COMPAT_SB_CHKSUM 		0x00000001
>  
>  /* 128-byte erofs on-disk super block */
>  struct erofs_super_block {
> @@ -37,8 +38,8 @@ struct erofs_super_block {
>  	__u8 uuid[16];          /* 128-bit uuid for volume */
>  	__u8 volume_name[16];   /* volume name */
>  	__le32 feature_incompat;
> -
> -	__u8 reserved2[44];
> +	__le32 chksum_blocks;	/* number of blocks used for checksum */
> +	__u8 reserved2[40];
>  };
>  
>  /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 544a453..cec27ca 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -86,7 +86,7 @@ struct erofs_sb_info {
>  	u8 uuid[16];                    /* 128-bit uuid for volume */
>  	u8 volume_name[16];             /* volume name */
>  	u32 feature_incompat;
> -
> +	u32 feature_compat;
>  	unsigned int mount_opt;
>  };
>  
> @@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> +#define EFSBADCRC	EBADMSG		/* Bad crc found */
>  
>  #endif	/* __EROFS_INTERNAL_H */
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0e36949..9cda72d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -9,6 +9,7 @@
>  #include <linux/statfs.h>
>  #include <linux/parser.h>
>  #include <linux/seq_file.h>
> +#include <linux/crc32c.h>
>  #include "xattr.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char *function,
>  	va_end(args);
>  }
>  
> +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
> +				       struct super_block *sb)
> +{
> +	u32 disk_chksum, nblocks, crc = 0;
> +	void *kaddr;
> +	struct page *page;
> +	int i;
> +
> +	disk_chksum = le32_to_cpu(dsb->checksum);
> +	nblocks = le32_to_cpu(dsb->chksum_blocks);

We cannot write the page data directly since the page cache should be kept in
sync with ondisk data (or for read-write fs, if it's claimed as uptodated, and
it is modified later,  you should mark it dirty, and do writeback then, but
that is not the erofs case.)

> +	dsb->checksum = 0;
> +	for (i = 0; i < nblocks; i++) {
> +		page = erofs_get_meta_page(sb, i);
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +		kaddr = kmap(page);

Here kmap_atomic(page) is better. what I mean is kmap_atomic() in the caller
erofs_read_superblock(), it should be replaced to kmap() instead.

> +		crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
> +		kunmap(page);
> +		unlock_page(page);

need
		put_page(page);


I'm not sure whether I explained quite well, but this patch needs something
to do. I'm now working on demonstrating new XZ algorithm and releasing
erofs-utils v1.0.

You can give more tries or I will help later. :-)

Thanks,
Gao Xiang


> +	}
> +	if (crc != disk_chksum)
> +		return -EFSBADCRC;
> +	return 0;
> +}
> +
>  static void erofs_inode_init_once(void *ptr)
>  {
>  	struct erofs_inode *vi = ptr;
> @@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
> +		ret = erofs_validate_sb_chksum(dsb, sb);
> +		if (ret < 0) {
> +			erofs_err(sb, "super block checksum incorrect");
> +			goto out;
> +		}
> +	}
>  	blkszbits = dsb->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (blkszbits != LOG_BLOCK_SIZE) {
> -- 
> 2.9.3
> 
